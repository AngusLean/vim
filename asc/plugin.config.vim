let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/usr/local/lib/gtags/gtags.conf'

"======================================================================
" Yggdroot/LeaderF  ctrlp replacement
"======================================================================
let g:Lf_ShortcutF = '<C-P>'
" let g:Lf_CommandMap = {'<C-C>': ['<Esc>', '<C-C>']}
" let g:Lf_Ctags = g:ctags_path
let g:Lf_WildIgnore = {
        \ 'dir': ['.svn','.git','.root','.project','node_modules'],
        \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.dll','*.o','*.so',
        \   '*.py[co]']
        \}

" don't show the help in normal mode
let g:Lf_HideHelp = 0
let g:Lf_UseCache = 1
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

" let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fc :<C-U><C-R>=printf("Leaderf function %s", "")<CR><CR>
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
" noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
" xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

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
  \             [ 'syntastic', 'cocstatus', 'readonly', 'asyncrun' ] ]
  \ },
  \ 'component': {
  \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}'
  \ },
  \ 'component_function': {
  \   'asyncrun': 'LightLineAsync',
  \   'syntastic': 'ALEGetStatusLine',
  \   'cocstatus': 'coc#status'
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
  " let s:running_status = g:vimmake_build_status
  let s:running_status = g:asyncrun_status
  if s:running_status == "running"
    return "asyn-running"
  elseif s:running_status == "success"
    return "asyn-exit"
  elseif s:running_status == "failure"
    return "asyn-fail"
  else
    return ""
  endif
endfunction

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

"----------------------------------------------------------------------
" asynctask
"----------------------------------------------------------------------

let g:asynctasks_extra_config = [
    \ g:vimrc_home.'/.vim/tasks.ini'
    \ ]

noremap <silent><f6> :AsyncTask file-run<cr>
noremap <silent><f5> :AsyncTask file-build<cr>
let g:asynctasks_term_pos = 'external'
let g:asynctasks_term_focus='0'
let g:asyncrun_shell='pwsh'

"======================================================================
" scrooloose/nerdtree
"======================================================================
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$']
map <F3> :NERDTreeToggle<CR>

"======================================================================
" Chiel92/vim-autoformat
"======================================================================
" let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline"
" let g:formatters_python = ['autopep8']
" noremap <F4> :Autoformat<CR>

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
" w0rp/ale async checker plugin
"=======================================================================
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'c':['gcc'],
\   'python':['pylint'],
\}

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_statusline_format = ['%d error(s)', '%d warning(s)', 'OK']
"let g:ale_lint_on_text_changed = 0
"let g:ale_lint_on_enter = 0
"let g_ale_lint_on_save=1
nmap <silent> <C-up> <Plug>(ale_previous_wrap)
nmap <silent> <C-down> <Plug>(ale_next_wrap)


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

let g:asyncrun_open = 0
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

nnoremap <c-F7> :AsyncStop <cr>
noremap  <F7> :call Toggle_QuickFix(8)<cr>

"----------------------------------------------------------------------
" UltiSnips
"----------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<m-h>"
let g:UltiSnipsJumpForwardTrigger="<m-j>"
let g:UltiSnipsJumpBackwardTrigger="<m-k>"
let g:UltiSnipsListSnippets="<m-l>"
" let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
" let g:UltiSnipsSnippetDirectories=['UltiSnips', s:home."/usnips"]


"======================================================================
"vim-gutentags
"======================================================================
set tags=./.tags;,.tags
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')
" let g:gutentags_trace = 1
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行
" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 1



"======================================================================
"colorscheme
"======================================================================
"colorscheme solarized
"colorscheme exlightgray
colorscheme gruvbox


"======================================================================
"coc.vim
"======================================================================

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Symbol renaming.
inoremap <S-F6> <Plug>(coc-rename)

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> fd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>


"======================================================================
"coc.vim coc-snipper
"======================================================================
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


"======================================================================
"vim-floaterm
"======================================================================
let g:floaterm_keymap_new    = '<c-F8>'
let g:floaterm_keymap_toggle = '<F8>'
let g:floaterm_shell = 'pwsh'


"======================================================================
"vimspector
"======================================================================
"let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
nmap <F11> <Plug>VimspectorToggleBreakpoint
nmap <F10> <Plug>VimspectorStepOver
nmap <C-F10> <Plug>VimspectorStepInto
nmap <M-F10> <Plug>VimspectorStepOut
nmap <F9> <Plug>VimspectorContinue
nmap <C-F9> <Plug>VimspectorStop
nmap <M-F9> :VimspectorReset<CR>

let g:vimspector_install_gadgets = [ 'vscode-python' ]
