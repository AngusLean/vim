
"======================================================================
" Yggdroot/LeaderF  ctrlp replacement
"======================================================================
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_CommandMap = {'<C-C>': ['<Esc>', '<C-C>']}
let g:Lf_Ctags = g:ctags_path
let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git','node_modules','.exvim*'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.dll','*.o','*.so',
        \   '*.py[co]']
        \}

nnoremap <leader>fc :LeaderfFunction<CR>

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
  \ 'subseparator': { 'left': " >", 'right': "|" },
  \ 'component_expand': {
  \   'syntastic': 'SyntasticStatuslineFlag',
  \ },
  \}

function! LightLineAsync()
  let s:running_status = g:vimmake_build_status
  " let s:running_status = g:asyncrun_status
  if s:running_status == "running"
    return "asyn-running"
  elseif s:running_status == "success"
    return "asyn-exit"
  elseif s:running_status == "failure"
    return "asyn-fail"
  else
    return ""
endfunction


"======================================================================
" scrooloose/nerdtree
"======================================================================
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$']
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
if g:iswindows
    let g:ctrlsf_ackprg='pt'
endif
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
" Plug 'majutsushi/tagbar'
"======================================================================

let g:tagbar_ctags_bin=g:ctags_path
nmap <F2> :TagbarToggle<CR>

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

" function! RunBackendTask()
    " exe 'AsyncRun ctags -R -f $(VIM_FILEDIR)/ctags.out --fields=+iaS %:p:h'
" endfunction

if g:iswindows
    let g:asyncrun_encs = 'gbk'
endif



" open quickfix
function! Toggle_QuickFix(size, ...)
	let l:mode = (a:0 == 0)? 2 : (a:1)
	function! s:WindowCheck(mode)
		if &buftype == 'quickfix'
			let s:quickfix_open = 1
			return
		endif
		if a:mode == 0
			let w:quickfix_save = winsaveview()
		else
			if exists('w:quickfix_save')
				call winrestview(w:quickfix_save)
				unlet w:quickfix_save
			endif
		endif
	endfunc
	let s:quickfix_open = 0
	let l:winnr = winnr()
	noautocmd windo call s:WindowCheck(0)
	noautocmd silent! exec ''.l:winnr.'wincmd w'
	if l:mode == 0
		if s:quickfix_open != 0
			silent! cclose
		endif
	elseif l:mode == 1
		if s:quickfix_open == 0
			exec 'botright copen '. ((a:size > 0)? a:size : ' ')
			wincmd k
		endif
	elseif l:mode == 2
		if s:quickfix_open == 0
			exec 'botright copen '. ((a:size > 0)? a:size : ' ')
			wincmd k
		else
			silent! cclose
		endif
	endif
	noautocmd windo call s:WindowCheck(1)
	noautocmd silent! exec ''.l:winnr.'wincmd w'
endfunc

nnoremap <c-F9> :AsyncStop <cr>
noremap <F10> :call Toggle_QuickFix(8)<cr>
" noremap <F12> runBackTask

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
let g:vimmake_save = 1
let g:vimmake_build_encoding = 'gbk'
"let g:vimmake_cwd = 1
"let g:asyncrun_timer = 50
let g:vimmake_build_timer = 50
let g:vimmake_build_name = 'make'
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



"======================================================================
"colorscheme
"======================================================================
"colorscheme solarized
"colorscheme exlightgray
colorscheme gruvbox

