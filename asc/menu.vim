function! menu#WinOpen(what)
    let root = expand('%:p:h')
    let cd = haslocaldir()? 'lcd ' : 'cd '
    let cwd = getcwd()
    exec cd . root
    if a:what == 'cmd'
        exec "silent !start cmd.exe"
    else
        exec "silent !start /b cmd.exe /C start ."
    endif
    exec cd . cwd
endfunc

function! s:snip(text)
	call append(line('.') - 1, a:text)
endfunc

"-----------------------------------------------------------------------
" guess comment
"-----------------------------------------------------------------------
function! s:comment()
	let l:ext = expand('%:e')
	if &filetype == 'vim'
		return '"'
	elseif index(['c', 'cpp', 'h', 'hpp', 'hh', 'cc', 'cxx'], l:ext) >= 0
		return '//'
	elseif index(['m', 'mm', 'java', 'go', 'delphi', 'pascal'], l:ext) >= 0
		return '//'
	elseif index(['coffee', 'as'], l:ext) >= 0
		return '//'
	elseif index(['c', 'cpp', 'rust', 'go', 'javascript'], &filetype) >= 0
		return '//'
	elseif index(['coffee'], &filetype) >= 0
		return '//'
	elseif index(['sh', 'bash', 'python', 'php', 'perl'], $filetype) >= 0
		return '#'
	elseif index(['make', 'ruby'], $filetype) >= 0
		return '#'
	elseif index(['py', 'sh', 'pl', 'php', 'rb'], l:ext) >= 0
		return '#'
	elseif index(['asm', 's'], l:ext) >= 0
		return ';'
	elseif index(['asm'], &filetype) >= 0
		return ';'
	elseif index(['sql'], l:ext) >= 0
		return '--'
	elseif index(['basic'], &filetype) >= 0
		return "'"
	endif
	return ""
endfunc


"-----------------------------------------------------------------------
" comment bar
"-----------------------------------------------------------------------
function! s:comment_bar(repeat, limit)
	let l:comment = s:comment()
	while strlen(l:comment) < a:limit
		let l:comment .= a:repeat
	endwhile
	return l:comment
endfunc


"-----------------------------------------------------------------------
" comment block
"-----------------------------------------------------------------------
function! menu#snip_comment_block(repeat)
	let l:comment = s:comment()
	let l:complete = s:comment_bar(a:repeat, 71)
	if l:comment == ''
		return
	endif
	call s:snip('')
	call s:snip(l:complete)
	call s:snip(l:comment . ' ')
	call s:snip(l:complete)
endfunc



" nnoremap <silent><F12> :call quickmenu#toggle(0)<cr>
" let g:quickmenu_options = 'LH'

" call quickmenu#current(0)
" call quickmenu#reset()
" call quickmenu#append('# Edit','')
" call quickmenu#append('run ',':VimExecute run<cr>','Run current file')
" call quickmenu#append('compile',':VimBuild gcc<cr>','Run current with gcc','c,cpp,h,hpp')
" call quickmenu#append('find current word',':GrepCode %{<cword>}','find current word in project')
" call quickmenu#append('find by ctrlsf',':GrepCode %{<cword>}','find current word in project')
" call quickmenu#append('toggle quickfix','call vimmake#toggle_quickfix(6)','toggle quickfix')

" call quickmenu#append('# Project','')
" call quickmenu#append('update ctags','call vimmake#update_tags(g:ctags_path, "ctags", ".tags")')
" call quickmenu#append('update csope','call vimmake#update_tags(g:ctags_path, "cs", ".cscope")')
" call quickmenu#append('update pysope','call vimmake#update_tags(g:ctags_path, "py", ".cscope")','py')

" if g:iswindows
    " call quickmenu#append('# System','')
	" call quickmenu#append('Open cmd', 'call menu#WinOpen("cmd")', 'Open cmd.exe in current file directory')
	" call quickmenu#append('Open explorer', 'call menu#WinOpen("")', 'Open Windows Explorer in current file directory')
" endif


" clear all the menus
call quickui#menu#reset()

" install a 'File' menu, use [text, command] to represent an item.
call quickui#menu#install('&File', [
            \ [ "&New File\tCtrl+n", 'echo 0' ],
            \ [ "&Open File\t(F3)", 'echo 1' ],
            \ [ "&Close", 'echo 2' ],
            \ [ "--", '' ],
            \ [ "&Save\tCtrl+s", 'echo 3'],
            \ [ "Save &As", 'echo 4' ],
            \ [ "Save All", 'echo 5' ],
            \ [ "--", '' ],
            \ [ "E&xit\tAlt+x", 'echo 6' ],
            \ ])

" items containing tips, tips will display in the cmdline
call quickui#menu#install('&Edit', [
            \ [ '&Copy', 'echo 1', 'help 1' ],
            \ [ '&Paste', 'echo 2', 'help 2' ],
            \ [ '&comment-', 'call menu#snip_comment_block("-")', 'help 3' ],
            \ [ '&comment=', 'call menu#snip_comment_block("=")', 'help 3' ],
            \ ])
call quickui#menu#install('&Build', [
            \ [ '&Build', 'AsyncTask file-build', 'build current file' ],
            \ [ '&Run', 'AsyncTask file-run', 'run current file' ],
            \ [ '[g pre, ]g next, fd/gy/gi/gr', 'echo 1' ],
            \ ])

" script inside %{...} will be evaluated and expanded in the string
call quickui#menu#install("&Project", [
			\ ['Build', 'AsyncTask project-build'],
			\ ['Run', 'AsyncTask project-run'],
			\ ['Open &Current In Terminal', 'call menu#WinOpen("cmd")'],
			\ ['Open Current In &FileExplore', 'call menu#WinOpen("")'],
			\ ['Set C&ursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
			\ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
			\ ])

call quickui#menu#install("&Coc", [
			\ ['diagnostics', 'CocList diagnostics'],
			\ ['extensios', 'CocList extensions'],
			\ ['commands', 'CocList commands'],
			\ ['symbols', 'CocList -I symbols'],
			\ ])

" register HELP menu with weight 10000
call quickui#menu#install('H&elp', [
			\ ["&Cheatsheet", 'help index', ''],
			\ ['T&ips', 'help tips', ''],
			\ ['--',''],
			\ ["&Tutorial", 'help tutor', ''],
			\ ['&Quick Reference', 'help quickref', ''],
			\ ['&Summary', 'help summary', ''],
			\ ], 10000)

" enable to display tips in the cmdline
let g:quickui_show_tip = 1

" hit space twice to open menu
noremap <space><space> :call quickui#menu#open()<cr>
