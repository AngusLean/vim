"======================================================================
"基本设置
"======================================================================


"/////////////////////////////////////////////////////////////////////////////
" Key Mappings
"/////////////////////////////////////////////////////////////////////////////

" NOTE: F10 looks like have some feature, when map with F10, the map will take no effects

" Don't use Ex mode, use Q for formatting
map Q gq

" define the copy/paste judged by clipboard
if &clipboard ==# 'unnamed'
    " fix the visual paste bug in vim
    " vnoremap <silent>p :call g:()<CR>
else
    " general copy/paste.
    " NOTE: y,p,P could be mapped by other key-mapping
    map <leader>y "*y
    map <leader>p "*p
    map <leader>P "*P
endif

" copy folder path to clipboard, foo/bar/foobar.c => foo/bar/
nnoremap <silent> <leader>y1 :let @*=fnamemodify(bufname('%'),":p:h")<CR>

" copy file name to clipboard, foo/bar/foobar.c => foobar.c
nnoremap <silent> <leader>y2 :let @*=fnamemodify(bufname('%'),":p:t")<CR>

" copy full path to clipboard, foo/bar/foobar.c => foo/bar/foobar.c
nnoremap <silent> <leader>y3 :let @*=fnamemodify(bufname('%'),":p")<CR>

" F8 or <leader>/:  Set Search pattern highlight on/off
nnoremap <ESC> :let @/=""<CR>
nnoremap <leader>/ :let @/=""<CR>

" map Ctrl-Tab to switch window
nnoremap <S-Up> <C-W><Up>
nnoremap <S-Down> <C-W><Down>
nnoremap <S-Left> <C-W><Left>
nnoremap <S-Right> <C-W><Right>

" enhance '<' '>' , do not need to reselect the block after shift it.
vnoremap < <gv
vnoremap > >gv

" map Up & Down to gj & gk, helpful for wrap text edit
noremap <Up> gk
noremap <Down> gj



"======================================================================
"快捷键
"======================================================================
"切换窗口
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
"分号进入命令模式
nnoremap ; :
"Q或Qa退出
noremap Q q
nnoremap Q <nop>
nmap K <nop>
noremap Qa qa
"取消F1键
nnoremap <F1> j

"vw选中当前单词
nmap vw viw
"映射选择全部
nmap <silent> <c-a> ggvG$
cmap PLugStatus :PlugStatus

"在quick-fix窗口直接q退出
"autocmd FileType q noremap <buffer> q :close<CR>
"aug QFClose
"  au!
"  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
"aug END
"======================================================================
" 平台相关设置
"======================================================================
if g:islinux
    " set guifont=Source\ Code\ Pro\ Bold\ 13
    "fix webpack-hot-reload not work in linux
    set backupcopy=yes
endif
if has('win32') || has('win64')
    noremap <space>gc :silent !start cmd.exe<cr>
    noremap <space>ge :silent !start /b cmd.exe /C start .<cr>
endif

" highlight Cursor guifg=white guibg=black
" highlight iCursor guifg=white guibg=steelblue
" set guicursor=n-v-c:block-Cursor
" set guicursor+=i:ver100-iCursor
" set guicursor+=n-v-c:blinkon0
" set guicursor+=i:blinkwait10

augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }
