Home config files and scripts
=============================

My personal vim configuration
-----------------------------

  * .vimrc
  * .vim/vimrc_files


Useful scripts and tools (~/bin)
--------------------------------

  * scl: (Not really) first version of scl (SCreen List) screen session management script.
  * vimrecover: Shorthand for recursively recover related files of all vim swapfiles in a tree.


Setup instructions:
-------------------

> (For read-only access)

    cd
    git init
    git remote add -t master -m master origin https://github.com/bitifet/dotfiles.git
    git pull
    ./.etc/_setup.sh
 
