
set nocompatible " be iMproved, required

function! OSX()
    return has('macunix')
endfunction
function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
function! WINDOWS()
    return  (has('win16') || has('win32') || has('win64'))
endfunction


if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if !exists('g:exvim_custom_path')
    if WINDOWS()
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
if WINDOWS()
    silent exec 'language english'
elseif OSX()
    silent exec 'language en_US'
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
if WINDOWS()
    " Be nice and check for multi_byte even if the config requires
    " multi_byte support most of the time
    if has('multi_byte')
        " Windows cmd.exe still uses cp850. If Windows ever moved to
        " Powershell as the primary terminal, this would be utf-8
        " set termencoding=cp850
	 set termencoding=utf-8
        " Let Vim use utf-8 internally, because many scripts require this
	set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,gbk,gb2312,latin1
        setglobal fileencoding=utf-8
	set encoding=utf-8
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

" ------------------------------------------------------------------
" Desc: Visual
" ------------------------------------------------------------------

set matchtime=0 " 0 second to show the matching paren ( much faster )
set nu " show line number
set scrolloff=0 " minimal number of screen lines to keep above and below the cursor
set nowrap " do not wrap text
set noacd " no autochchdir


"/////////////////////////////////////////////////////////////////////////////
" Auto Command
"/////////////////////////////////////////////////////////////////////////////

" ------------------------------------------------------------------
" Desc: Only do this part when compiled with support for autocommands.
" ------------------------------------------------------------------

if has('autocmd')

    augroup ex
        au!

        " ------------------------------------------------------------------
        " Desc: Buffer
        " ------------------------------------------------------------------

        " when editing a file, always jump to the last known cursor position.
        " don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        au BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
        au BufNewFile,BufEnter * set cpoptions+=d " NOTE: ctags find the tags file from the current path instead of the path of currect file
        au BufEnter * :syntax sync fromstart " ensure every file does syntax highlighting (full)
        au BufNewFile,BufRead *.avs set syntax=avs " for avs syntax file.

        " ------------------------------------------------------------------
        " Desc: file types
        " ------------------------------------------------------------------

        au FileType text setlocal textwidth=78 " for all text files set 'textwidth' to 78 characters.
        au FileType c,cpp,cs,swig set nomodeline " this will avoid bug in my project with namespace ex, the vim will tree ex:: as modeline.

        " disable auto-comment for c/cpp, lua, javascript, c# and vim-script
        au FileType c,cpp,java,javascript set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://
        au FileType cs set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f:///,f://
        au FileType vim set comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",f:\"
        au FileType lua set comments=f:--

        " if edit python scripts, check if have \t. ( python said: the programme can only use \t or not, but can't use them together )
        au FileType python,coffee call s:check_if_expand_tab()
    augroup END

    function! s:check_if_expand_tab()
        let has_noexpandtab = search('^\t','wn')
        let has_expandtab = search('^    ','wn')
        "
        if has_noexpandtab && has_expandtab
            let idx = inputlist ( ['ERROR: current file exists both expand and noexpand TAB, python can only use one of these two mode in one file.\nSelect Tab Expand Type:',
                        \ '1. expand (tab=space, recommended)',
                        \ '2. noexpand (tab=\t, currently have risk)',
                        \ '3. do nothing (I will handle it by myself)'])
            let tab_space = printf('%*s',&tabstop,'')
            if idx == 1
                let has_noexpandtab = 0
                let has_expandtab = 1
                silent exec '%s/\t/' . tab_space . '/g'
            elseif idx == 2
                let has_noexpandtab = 1
                let has_expandtab = 0
                silent exec '%s/' . tab_space . '/\t/g'
            else
                return
            endif
        endif

        "
        if has_noexpandtab == 1 && has_expandtab == 0
            echomsg 'substitute space to TAB...'
            set noexpandtab
            echomsg 'done!'
        elseif has_noexpandtab == 0 && has_expandtab == 1
            echomsg 'substitute TAB to space...'
            set expandtab
            echomsg 'done!'
        else
            " it may be a new file
            " we use original vim setting
        endif
    endfunction
endif
