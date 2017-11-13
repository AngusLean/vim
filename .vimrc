let g:vimrc_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

let g:configPath =g:vimrc_home.'/vimfiles/requirefile/windows/'
if g:islinux
    let g:configPath =g:vimrc_home.'/vimfiles/requirefile/linux/'
endif

let g:ctags_path=g:configPath.'/ctags/ctags.exe'
if g:islinux
    let g:configPath ='ctags'
endif

"/////////////////////////////////////////////////////////////////////////////
" 设置配置加载工具类
"/////////////////////////////////////////////////////////////////////////////

command! -nargs=1 IncScript exec 'so '.g:vimrc_home.'/'.'<args>'
exec 'set rtp+='.g:vimrc_home

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
