# /home/joanmi/.etc/git_commands.sh
# =================================

git-worktree-exec() {
  if ! command -v git >/dev/null 2>&1; then
    echo "git-worktree-exec: git: command not found" >&2
    return 1
  fi

  if [ $# -eq 0 ]; then
    cat <<'EOF'
Usage:
  git-worktree-exec <git-subcommand> [args...]

Description:
  Runs the given git command in every existing worktree of the current repository
  and shows each worktree's output under a highlighted header.

Examples:
  git-worktree-exec status
  git-worktree-exec branch --show-current
  git-worktree-exec log --oneline -n 3
  git-worktree-exec diff --stat

Notes:
  - Must be run from inside any worktree of the target repository.
  - Output is piped through 'less -R' to preserve colors.
  - The command is executed as:
      git -c color.ui=always --no-pager <git-subcommand> [args...]
EOF
    return 0
  fi

  local cmd="$1"
  shift || true
  local args=("$@")

  header_printer() {
    local header="$1"
    local len=${#header}
    local line1="=== "
    local line2
    local line3=" ==="
    local full_line

    line2=$(printf '=%.0s' $(seq 1 "$len"))
    full_line="${line1}${line2}${line3}"

    printf '\n\033[1;43m%s\033[0m' "$full_line"
    printf '\n\033[1;43m%s\033[0m' "${line1}${header}${line3}"
    printf '\n\033[1;43m%s\033[0m' "$full_line"
    printf '\n'
  }

  {
    git worktree list --porcelain \
      | awk '/^worktree /{sub(/^worktree /,""); print}' \
      | while IFS= read -r wt; do
          header_printer "$wt"
          (cd "$wt" && git -c color.ui=always --no-pager "$cmd" "${args[@]}")
        done
  } | less -R -F
}

#alias lswt='git worktree list'
lswt() {
  local commit_hash head_short branch_mark
  head_short=$(git rev-parse --short HEAD)
  while IFS= read -r line; do
    # Extract commit hash (second field)
    commit_hash=$(echo "$line" | awk '{print $2}')
    if [ "$commit_hash" = "$head_short" ]; then
      branch_mark="✅ "
    elif git merge-base --is-ancestor "$commit_hash" HEAD 2>/dev/null; then
      branch_mark="✔️ "
    else
      branch_mark="   "
    fi
    # Insert mark before commit hash
    echo "$line" | sed -E "s/([[:space:]]+)($commit_hash)/\1$branch_mark\2/"
  done < <(git worktree list)
}


cdwt() {
  local target="${1:-main}"
  local main_path common_dir
  local wt_path=""
  local wt_branch=""
  local matches=()

  common_dir=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || {
    echo "cdwt: not inside a git repository" >&2
    return 1
  }

  main_path=$(cd "$common_dir/.." && pwd -P) || {
    echo "cdwt: could not determine main worktree" >&2
    return 1
  }

  while IFS= read -r line; do
    case "$line" in
      worktree\ *)
        wt_path=${line#worktree }
        wt_branch=""
        ;;
      branch\ refs/heads/*)
        wt_branch=${line#branch refs/heads/}
        ;;
      "")
        if [ "$target" = "main" ]; then
          if [ "$wt_path" = "$main_path" ]; then
            cd "$wt_path" || return
            return
          fi
        else
          if [ "$wt_branch" = "$target" ] || [ "${wt_path##*/}" = "$target" ]; then
            matches+=("$wt_path")
          fi
        fi
        ;;
    esac
  done < <(git worktree list --porcelain; printf '\n')

  if [ "$target" = "main" ]; then
    echo "cdwt: main worktree not found" >&2
    return 1
  fi

  # Remove duplicates:
  mapfile -t matches < <(printf '%s\n' "${matches[@]}" | sort -u)

  case "${#matches[@]}" in
    0)
      echo "cdwt: no worktree found for '$target'" >&2
      return 1
      ;;
    1)
      cd "${matches[0]}" || return
      ;;
    *)
      echo "cdwt: ambiguous target '$target':" >&2
      printf '  %s\n' "${matches[@]}" >&2
      return 1
      ;;
  esac
}


rmwt() {
  local target="${1:-}"

  if [ -z "$target" ]; then
    echo "Usage: rmwt <worktree-path-or-branch>" >&2
    return 1
  fi

  git worktree remove "${target}" && git branch -d "$(basename "${target}")"
};

