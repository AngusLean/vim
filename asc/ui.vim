
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


" set default guifont
if has('gui_running')
    augroup ex_gui_font
        " check and determine the gui font after GUIEnter.
        " NOTE: getfontname function only works after GUIEnter.
        au!
        au GUIEnter * call s:set_gui_font()
    augroup END

    " set guifont
    function! s:set_gui_font()
        if has('gui_gtk2')
            if getfontname('SourceCodePro') != ''
                "set guifont=SourceCodePro\ 14
                set guifont=Droid\ Sans\ Mono\ 14
            elseif getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 14
            elseif getfontname( 'DejaVu Sans Mono' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ 14
            else
                set guifont=Luxi\ Mono\ 14
            endif
        elseif has('x11')
            " Also for GTK 1
            set guifont=*-lucidatypewriter-medium-r-normal-*-*-180-*-*-m-*-*
        elseif OSX()
            if getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h15
            elseif getfontname( 'DejaVu Sans Mono' ) != ''
                set guifont=DejaVu\ Sans\ Mono:h15
            endif
        elseif WINDOWS()
            if getfontname( 'DejaVu Sans Mono for Powerline' ) != ''
                set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h13:cANSI
            elseif getfontname( 'DejaVu Sans Mono' ) != ''
                set guifont=DejaVu\ Sans\ Mono:h13:cANSI
            elseif getfontname( 'Consolas' ) != ''
                set guifont=Consolas:h13:cANSI " this is the default visual studio font
            else
                set guifont=Lucida_Console:h13:cANSI
            endif
        endif
    endfunction
endif

" ------------------------------------------------------------------
" Desc: Vim UI
" ------------------------------------------------------------------

set wildmenu " turn on wild menu, try typing :h and press <Tab>
set showcmd " display incomplete commands
set cmdheight=2 " 1 screen lines to use for the command-line
set ruler " show the cursor position all the time
set hidden " allow to change buffer without saving
set shortmess=aoOtTI " shortens messages to avoid 'press a key' prompt
set lazyredraw " do not redraw while executing macros (much faster)
set display+=lastline " for easy browse last line with wrap text
set laststatus=2 " always have status-line
set titlestring=%t\ (%{expand(\"%:p:.:h\")}/)

" set window size (if it's GUI)
if has('gui_running')
    " set window's width to 130 columns and height to 40 rows
    if exists('+lines')
        set lines=40
    endif
    if exists('+columns')
        set columns=130
    endif

    " DISABLE
    " if WINDOWS()
    "     au GUIEnter * simalt ~x " Maximize window when enter vim
    " else
    "     " TODO: no way right now
    " endif
endif

set showfulltag " show tag with function protype.
set guioptions-=b " present the bottom scrollbar when the longest visible line exceed the window

" disable menu & toolbar
set guioptions-=m
set guioptions-=T
set guioptions-=R
if has("gui_running")
    set guioptions-=r
    set guioptions-=L
endif

" ------------------------------------------------------------------
" Desc: Text edit
" ------------------------------------------------------------------

set ai " autoindent
set si " smartindent
set backspace=indent,eol,start " allow backspacing over everything in insert mode

set	cinoptions=>s,e0,n0,f0,{0,}0,^0,:0,=s,l0,b0,g0,hs,ps,ts,is,+s,c3,C0,0,(0,us,U0,w0,W0,m0,j0,)20,*30


" official diff settings
set diffexpr=g:MyDiff()
function! g:MyDiff()
    let opt = '-a --binary -w '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    silent execute '!' .  'diff ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
endfunction

set cindent shiftwidth=4 " set cindent on to autoinent when editing c/c++ file, with 4 shift width
set tabstop=4 " set tabstop to 4 characters
set expandtab " set expandtab on, the tab will be change to space automaticaly
set ve=block " in visual block mode, cursor can be positioned where there is no actual character

" set Number format to null(default is octal) , when press CTRL-A on number
" like 007, it would not become 010
set nf=

" ------------------------------------------------------------------
" Desc: Fold text
" ------------------------------------------------------------------
set foldmethod=marker foldmarker={,} foldlevel=9999
set diffopt=filler,context:9999

" ------------------------------------------------------------------
" Desc: Search
" ------------------------------------------------------------------

set showmatch " show matching paren
set incsearch " do incremental searching
set hlsearch " highlight search terms
set ignorecase " set search/replace pattern to ignore case
set smartcase " set smartcase mode on, If there is upper case character in the search patern, the 'ignorecase' option will be override.


set foldenable                                    "启用折叠
set foldmethod=indent                             "indent 折叠方式
set breakindent                                   "vim8中加入的复制内容保持缩进
set matchpairs=(:),{:},[:],<:>                    "匹配括号的规则。
