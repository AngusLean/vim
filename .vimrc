let g:vimrc_home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if !exists('g:exvim_custom_path')
    if g:iswindows
        set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    endif
endif

"/////////////////////////////////////////////////////////////////////////////
" language and encoding setup
"/////////////////////////////////////////////////////////////////////////////

" always use English menu
" NOTE: this must before filetype off, otherwise it won't work
set langmenu=none

" use English for anaything in vim-editor.
if g:iswindows
    silent exec 'language english'
else
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        " in mac-terminal
        silent exec 'language en_US'
    else
        " in linux-terminal
        silent exec 'language en_US.utf8'
    endif
endif

" try to set encoding to utf-8
if g:iswindows
    " Be nice and check for multi_byte even if the config requires
    " multi_byte support most of the time
    if has('multi_byte')
        " Windows cmd.exe still uses cp850. If Windows ever moved to
        " Powershell as the primary terminal, this would be utf-8
        " set termencoding=cp850
	 set termencoding=utf-8
        " Let Vim use utf-8 internally, because many scripts require this
	set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
        setglobal fileencoding=utf-8
	set encoding=utf-8
	" 英文版的Windows7，Vim7.4—英文Windows下的Vim不知道如何显示双倍字符
	" 宽度的字体！你必须告诉它：
	" set gfn=Monaco:h10:cANSI
	" set gfw=NSimsun:h12
    endif

else
    " set default encoding to utf-8
    set encoding=utf-8
    set termencoding=utf-8
    language messages zh_CN.utf-8
endif
scriptencoding utf-8
language messages zh_CN.utf-8



"/////////////////////////////////////////////////////////////////////////////
" vim-plug steup
"/////////////////////////////////////////////////////////////////////////////
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
"exec 'set rtp+='.s:home
command! -nargs=1 IncScript exec 'so '.s:home.'/'.'<args>'

if has("python") || has("python3")
    let g:plug_threads = 10
else
    let g:plug_threads = 1
endif

call plug#begin(s:home.'/vimfiles/plugged')
IncScript .vimrc.plugins
call plug#end()
IncScript .vimrc.plugins.config

filetype plugin indent on " required
syntax on " required

"/////////////////////////////////////////////////////////////////////////////
" Default colorscheme setup
"/////////////////////////////////////////////////////////////////////////////
syntax enable
if has('gui_running')
    set background=dark
else
    set background=dark
    " if you set you terminal to solarized colorscheme ,you don't need
    " above two lines. in gnome-terminal,you should visit the:
    "    https://github.com/Anthony25/gnome-terminal-colors-solarized
    " set t_Co=256 " make sure our terminal use 256 color
    " let g:solarized_termcolors = 256
endif
colorscheme solarized
"colorscheme exlightgray

"/////////////////////////////////////////////////////////////////////////////
" General
"/////////////////////////////////////////////////////////////////////////////

set backup " make backup file and leave it around

" setup back and swap directory
let data_dir=$HOME.'/.data/vim/'
let backup_dir=data_dir . 'backup'
let swap_dir=data_dir . 'swap'
let session_dir=data_dir . 'session'
if finddir(data_dir) == ''
    silent call mkdir(data_dir)
endif
if finddir(backup_dir) == ''
    silent call mkdir(backup_dir)
endif
if finddir(swap_dir) == ''
    silent call mkdir(swap_dir)
endif
if finddir(session_dir) == ''
    silent call mkdir(session_dir)
endif
unlet backup_dir
unlet swap_dir
unlet data_dir

set backupdir=$HOME/.data/vim/backup " where to put backup file
set directory=$HOME/.data/vim/swap " where to put swap file

" Redefine the shell redirection operator to receive both the stderr messages and stdout messages
set shellredir=>%s\ 2>&1
set history=50 " keep 50 lines of command line history
set updatetime=1000 " default = 4000
set autoread " auto read same-file change ( better for vc/vim change )
set maxmempattern=1000 " enlarge maxmempattern from 1000 to ... (2000000 will give it without limit)

"/////////////////////////////////////////////////////////////////////////////
" xterm settings
"/////////////////////////////////////////////////////////////////////////////

behave xterm  " set mouse behavior as xterm
if &term =~ 'xterm'
    set mouse=a
endif

"/////////////////////////////////////////////////////////////////////////////
" Variable settings ( set all )
"/////////////////////////////////////////////////////////////////////////////

" ------------------------------------------------------------------
" Desc: Visual
" ------------------------------------------------------------------

set matchtime=0 " 0 second to show the matching paren ( much faster )
set nu " show line number
set scrolloff=0 " minimal number of screen lines to keep above and below the cursor
set nowrap " do not wrap text

" only supoort in 7.3 or higher
" if v:version >= 703
    " set noacd " no autochchdir

let g:configPath =g:vimrc_home.'/vimfiles/requirefile/windows/'
if g:islinux
    let g:configPath =g:vimrc_home.'/vimfiles/requirefile/linux/'
endif

let g:ctags_path=g:configPath.'/ctags.exe'
if g:islinux
    let g:ctags_path ='ctags'
    " let $GTAGSCONF = '/usr/local/lib/gtags/gtags.conf'
endif
let $GTAGSLABEL = 'native-pygments'

"/////////////////////////////////////////////////////////////////////////////
" 设置配置加载工具类
"/////////////////////////////////////////////////////////////////////////////

command! -nargs=1 IncScript exec 'so '.g:vimrc_home.'/'.'<args>'
exec 'set rtp+='.g:vimrc_home

nnoremap <leader>qq :so %

IncScript asc/basic.vim
IncScript asc/ui.vim

IncScript asc/plugin.vim
IncScript asc/plugin.config.vim

"/////////////////////////////////////////////////////////////////////////////
" 加载配置
"/////////////////////////////////////////////////////////////////////////////

IncScript asc/start.vim
IncScript asc/config.vim
IncScript asc/ignores.vim
" IncScript asc/complete.vim
IncScript asc/menu.vim
