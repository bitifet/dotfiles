" /home/joanmi/.vim/vimrc_files/ai.vim
" ====================================

" -----------------------------------------------------------------
" AI related mappings and functions
" This file contains mappings and functions related to AI tools and
" integrations.
" -----------------------------------------------------------------

" AgentP integration
" ------------------
" This function saves the current buffer, runs AgentP with the selected
" text, and then updates the buffer with the output from AgentP. The mapping
" allows you to select a block of text in visual mode and then press
" <Leader><CR> to run AgentP on that text.
function! s:AgentPWithSave() range
  silent! update
  execute a:firstline . "," . a:lastline . "!agentp --qa $(ocmux)"
  silent! update
endfunction

xmap <Leader><CR> :call <SID>AgentPWithSave()<<CR>
