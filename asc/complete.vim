
let g:complete_plugin = 'ycm'
"======================================================================
"设置补全插件
"======================================================================

"neocomplete {{{
if g:complete_plugin ==? 'neo'
    " Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 2
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default' : '',
                \ 'arduino' : $VIM.'/vimfiles/requirefile/dict/arduino.dict',
                \ 'c' : $VIM.'/vimfiles/requirefile/dict/c.dict',
                \ 'cpp' : $VIM.'/vimfiles/requirefile/dict/cpp.dict',
                \ 'css' : $VIM.'/vimfiles/requirefile/dict/css.dict',
                \ 'java' : $VIM.'/vimfiles/requirefile/dict/java.dict',
                \ 'javascript' : $VIM.'/vimfiles/requirefile/dict/javascript.dict',
                \ 'php' : $VIM.'/vimfiles/requirefile/dict/php.dict',
                \ 'vim' : $VIM.'/vimfiles/requirefile/dict/vim.dict',
                \ 'matlab' : $VIM.'/vimfiles/requirefile/dict/matlab.dict',
                \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.

    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    "inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    "inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    "inoremap <expr><C-y>  neocomplete#close_popup()
    "inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    " For cursor moving in insert mode(Not recommended)
    inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
    inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
    inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
    inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
    "" Or set this.
    "let g:neocomplete#enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplete#enable_insert_char_pre = 1

    " AutoComplPop like behavior.
    " let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType vue setlocal omnifunc=htmlcomplete#CompleteTags

    " Enable heavy omni completion.
    " if !exists('g:neocomplete#sources#omni#input_patterns')
    " let g:neocomplete#sources#omni#input_patterns = {}
    " endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    "}}}
    "Valloric/YouCompleteMe {{{
elseif g:complete_plugin ==? 'ycm'
    let g:ycm_confirm_extra_conf=0   "设置加载py文件不提示
    "设置离开插入模式自动关闭预览窗口
    let g:ycm_autoclose_preview_window_after_insertion=1
    "设置选择预览数据过后自动关闭
    let g:ycm_autoclose_preview_window_after_completion =1
    if g:iswindows
        let g:ycm_python_binary_path="C:/Program Files/Python36/python.exe"
        let g:ycm_global_ycm_extra_conf = 'D:\Program Files (x86)\software\dev\vimconfig\vimfiles\requirefile\windows/.ycm_extra_conf.py'
    else
        let g:ycm_python_binary_path="/usr/bin/python3.5"
        let g:ycm_global_ycm_extra_conf = '~/software/exvim1/vimfiles/requirefile/linux/.ycm_extra_conf.py'
    endif
    let g:ycm_filetype_whitelist = { 'c': 1 ,'cpp' : 1,'h':1,'javascript':1,'html':1,'htm':1,'python':1 }

    " YCM 集成 OmniCppComplete 补全引擎
    inoremap <leader>; <C-x><C-o>
    " 设置转到定义处的快捷键为ALT + G，
    "nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>
    nnoremap <M-g> :YcmCompleter GoTo <CR>
    "命名模式下ycm映射到YcmCompleter
    "cmap ycm YcmCompleter
    autocmd FileType javascript nnoremap <M-F7> :YcmCompleter GoToReferences<cr>
    autocmd FileType javascript nnoremap <S-F6> :YcmCompleter RefactorRename<space>
    " 补全功能在注释中同样有效
    let g:ycm_complete_in_comments=1
    " 开启标签补全
    " let g:ycm_collect_identifiers_from_tags_files = 1
    " set tags+='e:\.symbs\cpp_src\tags' "C++标准库的tags
    " 从第一个键入字符就开始罗列匹配项
    let g:ycm_min_num_of_chars_for_completion=2
    " 离开插入模式后自动关闭预览窗口
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
    " 禁止缓存匹配项，每次都重新生成匹配项
    "let g:ycm_cache_omnifunc = 1
    " 语法关键字补全
    let g:ycm_seed_identifiers_with_syntax=1
    " 修改对C函数的补全快捷键，默认是CTRL + space，修改为ALT + ;
    let g:ycm_key_invoke_completion = '<M-;>'
    " 回车即选中当前项
    inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
endif
"}}}


