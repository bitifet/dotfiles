
" Subversion:
command! -nargs=* Svndiff !svn<space>diff<space><args><space>%|less 
command! Svncommit !svn<space>commit<space>%
command! Svninfo !svn<space>info<space>%|less 
command! Svnlog !svn<space>log<space>%|less 
command! Svnadd !svn<space>add<space>%
command! Svnstatus !svn<space>status<space>%
command! Svnrevert !svn<space>revert<space>%

