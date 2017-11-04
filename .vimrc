let g:vimrc_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
command! -nargs=1 IncScript exec 'so '.g:vimrc_home.'/'.'<args>'
exec 'set rtp+='.g:vimrc_home
let g:vimrc_home = g:vimrc_home

IncScript asc/basic.vim
IncScript asc/ui.vim

IncScript asc/vimmake.vim
VimmakeKeymap


IncScript asc/plugin.vim
IncScript asc/plugin.config.vim

"/////////////////////////////////////////////////////////////////////////////
" 加载配置
"/////////////////////////////////////////////////////////////////////////////

"IncScript asc/start.vim
IncScript asc/config.vim
IncScript asc/ignores.vim
IncScript asc/misc.vim
IncScript asc/complete.vim
"IncScript asc/runcurrent.vim
" vim:ts=4:sw=4:sts=4 et fdm=marker:
