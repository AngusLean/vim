
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

nnoremap <silent><F12> :call quickmenu#toggle(0)<cr>
let g:quickmenu_options = 'LH'

call quickmenu#current(0)
call quickmenu#reset()
call quickmenu#append('# Edit','')
call quickmenu#append('run ',':VimExecute run<cr>','Run current file')
call quickmenu#append('compile',':VimBuild gcc<cr>','Run current with gcc','c,cpp,h,hpp')
call quickmenu#append('find current word',':GrepCode %{<cword>}','find current word in project')
call quickmenu#append('find by ctrlsf',':GrepCode %{<cword>}','find current word in project')
call quickmenu#append('toggle quickfix','call vimmake#toggle_quickfix(6)','toggle quickfix')

call quickmenu#append('# Project','')
call quickmenu#append('update ctags','call vimmake#update_tags(g:ctags_path, "ctags", ".tags")')
call quickmenu#append('update csope','call vimmake#update_tags(g:ctags_path, "cs", ".cscope")')
call quickmenu#append('update pysope','call vimmake#update_tags(g:ctags_path, "py", ".cscope")','py')

if g:iswindows
    call quickmenu#append('# System','')
	call quickmenu#append('Open cmd', 'call menu#WinOpen("cmd")', 'Open cmd.exe in current file directory')
	call quickmenu#append('Open explorer', 'call menu#WinOpen("")', 'Open Windows Explorer in current file directory')
endif
