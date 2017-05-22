"======================================================================
"基本设置
"======================================================================
set foldenable                                    "启用折叠
set foldmethod=indent                             "indent 折叠方式
set breakindent                                   "vim8中加入的复制内容保持缩进
set matchpairs=(:),{:},[:],<:>                    "匹配括号的规则。
" 用空格键来开关折叠
"  <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" 设置字体
" set guifont=YaHei\ Consolas\ Hybrid\ 12
"光标不闪烁
" set gcr=a:block-blinkon0

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
"vw选中当前单词
nmap vw viw
"Q或Qa退出
noremap Q q
noremap Qa qa

"映射选择全部
nmap <silent> <c-a> ggvG$
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
