
"let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
"exec 'set rtp+='.s:home
"command! -nargs=1 IncScript exec 'so '.s:home.'/'.'<args>'

let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
command! -nargs=1 IncScript exec 'so '.s:home.'/'.'<args>'
exec 'set rtp+='.s:home


IncScript asc/basic.vim
IncScript asc/ui.vim

if has("python") || has("python3")
    let g:plug_threads = 10
else
    let g:plug_threads = 1
endif

call plug#begin(s:home.'/vimfiles/plugged')
IncScript asc/plugin.vim
call plug#end()
IncScript asc/plugin.config.vim

filetype plugin indent on
syntax on " required

"/////////////////////////////////////////////////////////////////////////////
" 加载配置
"/////////////////////////////////////////////////////////////////////////////

"IncScript asc/start.vim
IncScript asc/config.vim
IncScript asc/ignores.vim
IncScript asc/misc.vim
IncScript asc/complete.vim
IncScript asc/runcurrent.vim
" vim:ts=4:sw=4:sts=4 et fdm=marker:
