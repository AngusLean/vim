
"======================================================================
" Yggdroot/LeaderF  ctrlp replacement
"======================================================================
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git','node_modules','.exvim*'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.dll','*.o','*.so',
        \   '*.py[co]']
        \}

"======================================================================
" tpope/vim-surround
"======================================================================
xmap s <Plug>VSurround

"======================================================================
" itchyny/lightline.vim
"======================================================================
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode'],['filename'],
  \             [ 'syntastic','readonly', 'asyncrun' ] ]
  \ },
  \ 'component': {
  \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}'
  \ },
  \ 'component_function': {
  \   'asyncrun': 'LightLineAsync',
  \   'syntastic': 'ALEGetStatusLine'
  \ },
  \ 'component_visible_condition': {
  \   'readonly': '(&filetype!="help"&& &readonly)'
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\u2b82" },
  \ 'subseparator': { 'left': " >", 'right': "|" }
  \ }

"    \ 'component_expand': {
"    \   'syntastic': 'SyntasticStatuslineFlag',
"    \ },
function! LightLineAsync()
  if g:asyncrun_status == "running"
    return "asyn-running"
  elseif g:asyncrun_status == "success"
    return "asyn-exit"
  elseif g:asyncrun_status == "failure"
    return "asyn-fail"
  else
    return ""
endfunction


"======================================================================
" scrooloose/nerdtree
"======================================================================
let NERDTreeShowHidden=1
map <F3> :NERDTreeToggle<CR>

"======================================================================
" Chiel92/vim-autoformat
"======================================================================
let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
let g:formatters_python = ['autopep8']
noremap <F4> :Autoformat<CR>

"======================================================================
"scrooloose/nerdcommenter
"======================================================================
"nerdcommenter: invoke by <leader>c<space>, <leader>cl, <leader>cu, <F11> or <C-F11>
"let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1
let g:NERDCustomDelimiters = {
            \ 'vimentry': { 'left': '--' },
            \ }
nnoremap <leader>cc :NERDComToggleComment<CR>


"======================================================================
" scrooloose/syntastic
"======================================================================
let g:syntastic_javascript_checkers = ['eslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 0
"let g:syntastic_check_on_wq = 0
"this will make html file by Angular.js ignore errors
"let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]


"======================================================================
" w0rp/ale async checker plugin
"=======================================================================
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'c':['gcc'],
\   'python':['pylint'],
\}
let g:ale_statusline_format = ['%d error(s)', '%d warning(s)', 'OK']
"let g:ale_lint_on_text_changed = 0
"let g:ale_lint_on_enter = 0
"let g_ale_lint_on_save=1
nmap <silent> <C-up> <Plug>(ale_previous_wrap)
nmap <silent> <C-down> <Plug>(ale_next_wrap)


"======================================================================
" dyng/ctrlsf.vim
"======================================================================
let g:ctrlsf_case_sensitive = 'no'
let g:ctrlsf_auto_close = 1
" 高亮匹配行: o->打开的目标文件;p->预览文件
let g:ctrlsf_selected_line_hl = 'op'
" 默认搜索路径, 设置为project则从本文件的工程目录搜索
" let g:ctrlsf_default_root = 'project+wf'
" 工程目录的顶级文件夹
" let g:ctrlsf_vcs_folder = ['.exvim', '.git', '.hg', '.svn', '.bzr', '_darcs']
" make result windows compact
let g:ctrlsf_ackprg='pt'
let g:ctrlsf_indent = 2
let g:ctrlsf_regex_pattern = 1
vmap     <C-F> <Plug>CtrlSFVwordPath
nmap     <C-F> <Plug>CtrlSFCwordPath
nmap     <C-S-F> <Plug>CtrlSFPwordPath
" nmap     <C-F>f <Plug>CtrlSFPrompt
" vmap     <C-F>F <Plug>CtrlSFVwordExec
" nnoremap <C-F>o :CtrlSFOpen<CR>
" nnoremap <C-F>t :CtrlSFToggle<CR>
" inoremap <C-F>t <Esc>:CtrlSFToggle<CR>


"======================================================================
" kristijanhusak/vim-multiple-cursors
"======================================================================
" let g:multi_cursor_use_default_mapping = 0
" let g:multi_cursor_start_word_key = '<C-j>'
" let g:multi_cursor_next_key = '<C-j>'
" let g:multi_cursor_prev_key = '<C-k>'
" let g:multi_cursor_skip_key = '<C-x>'
" let g:multi_cursor_quit_key = '<ESC>'
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction
" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction


"======================================================================
" vim-scripts/LargeFile
"======================================================================
let g:LargeFile= 5 " files >= 5MB will use LargeFile rules


"======================================================================
" emmet-vim
"======================================================================
let g:user_emmet_install_global = 0
autocmd FileType html,vue,css,jsp EmmetInstall
let g:user_emmet_settings={
\   'vue':{
\       'extends': 'html,javascript,css',
\   }
\}


"======================================================================
" godlygeek/tabular
"======================================================================
nnoremap <silent> <leader>= :call g:Tabular(1)<CR>
xnoremap <silent> <leader>= :call g:Tabular(0)<CR>
function! g:Tabular(ignore_range) range
   let c = getchar()
   let c = nr2char(c)
    if a:ignore_range == 0
        exec printf('%d,%dTabularize /%s', a:firstline, a:lastline, c)
    else
        exec printf('Tabularize /%s', c)
    endif
endfunction

"======================================================================
" plasticboy/vim-markdown
"======================================================================
let g:vim_markdown_initial_foldlevel=9999

"======================================================================
" ntpeters/vim-better-whitespace
"======================================================================
autocmd BufWritePre * StripWhitespace

"======================================================================
" othree/yajs.vim
"======================================================================
let g:smc = 100
let g:used_javascript_libs = 'vue'

"======================================================================
" maksimr/vim-jsbeautify
"======================================================================
autocmd FileType javascript noremap <buffer>  <leader>f :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <leader>f :call JsonBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <leader>f :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <leader>f :call CSSBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <leader>f :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <leader>f :call RangeJsonBeautify()<cr>
autocmd FileType html vnoremap <buffer> <leader>f :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <leader>f :call RangeCSSBeautify()<cr>
autocmd FileType vue vnoremap <buffer> <leader>fh :call RangeHtmlBeautify()<cr>
autocmd FileType vue vnoremap <buffer> <leader>fc :call RangeCSSBeautify()<cr>
autocmd FileType vue vnoremap <buffer> <leader>fj :call RangeJsBeautify()<cr>


"======================================================================
" skywind3000/asyncrun.vim
"======================================================================
augroup vimrc
    autocmd QuickFixCmdPost * botright copen 8
augroup END

if g:iswindows
    let g:asyncrun_encs = 'gbk'
endif
nnoremap <c-F9> :AsyncStop <cr>
noremap <F10> :call asyncrun#quickfix_toggle(8)<cr>

"----------------------------------------------------------------------
" UltiSnips
"----------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<m-h>"
let g:UltiSnipsJumpForwardTrigger="<m-j>"
let g:UltiSnipsJumpBackwardTrigger="<m-k>"
let g:UltiSnipsListSnippets="<m-l>"
" let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
" let g:UltiSnipsSnippetDirectories=['UltiSnips', s:home."/usnips"]


"----------------------------------------------------------------------
" vimmake / asyncrun
"----------------------------------------------------------------------
let g:vimmake_path = g:configPath.'/vimmake'
"let g:vimmake_cwd = 1
"let g:asyncrun_timer = 50
"let g:vimmake_build_timer = 50
"let g:vimmake_build_name = 'make'
"let g:vimmake_save = 1
"let s:python = executable('python2')? 'python2' : 'python'
"let s:script = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
"let s:launch = s:script . '/vimfiles/requirefile/lib/launch.py'

"if filereadable(s:launch)
"	let s:hz = g:vimmake_build_timer * 10 * 80 / 100
"	let g:vimmake_build_shell_bak = s:python
"	let g:vimmake_build_shellflag = s:launch
"	let g:asyncrun_shell_bak = s:python
"	let g:asyncrun_shellflag = s:launch
"	let $VIM_LAUNCH_HZ = ''. s:hz
"endif

"----------------------------------------------------------------------
"YouCompleteMe
"----------------------------------------------------------------------
let g:ycm_filetype_whitelist = {
			\ "c":1,
			\ "cpp":1,
			\ "objc":1,
			\ "objcpp":1,
			\ "python":1,
			\ "java":1,
			\ "javascript":1,
			\ "coffee":1,
			\ "vim":1,
			\ "go":1,
			\ "cs":1,
			\ "lua":1,
			\ "perl":1,
			\ "perl6":1,
			\ "php":1,
			\ "ruby":1,
			\ "rust":1,
			\ "erlang":1,
			\ "asm":1,
			\ "nasm":1,
			\ "masm":1,
			\ "tasm":1,
			\ "asm68k":1,
			\ "asmh8300":1,
			\ "asciidoc":1,
			\ "basic":1,
			\ "vb":1,
			\ "make":1,
			\ "cmake":1,
			\ "html":1,
			\ "css":1,
			\ "less":1,
			\ "json":1,
			\ "cson":1,
			\ "typedscript":1,
			\ "haskell":1,
			\ "lhaskell":1,
			\ "lisp":1,
			\ "scheme":1,
			\ "sdl":1,
			\ "sh":1,
			\ "zsh":1,
			\ "bash":1,
			\ "man":1,
			\ "markdown":1,
			\ "matlab":1,
			\ "maxima":1,
			\ "dosini":1,
			\ "conf":1,
			\ "config":1,
			\ "zimbu":1,
			\ }


"======================================================================
"colorscheme
"======================================================================
"colorscheme solarized
"colorscheme exlightgray
colorscheme gruvbox
