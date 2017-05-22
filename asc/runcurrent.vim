"-----------------------------------------------------------------------------"
" -----------------------------------------------------------------------------
"  < 编译、连接、运行配置 (目前只配置了C、C++、Java语言)>
" -----------------------------------------------------------------------------

" F9 一键保存、编译、连接存并运行
nmap <F8> :call <SID>async_run()<CR>
nmap <c-F8> :call <SID>async_stoprun()<CR>

" Ctrl + F9 一键保存并编译
" nmap <c-F9> :call Compile()<CR>
" imap <c-F9> <ESC>:call Compile()<CR>

" Ctrl + F10 一键保存并连接
" nmap <c-F10> :call Link()<CR>
" imap <c-F10> <ESC>:call Link()<CR>

let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Class_Extension = '.class'
let s:Sou_Error = 0

let s:windows_CFlags = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:windows_CPPFlags = 'clang++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
" let s:windows_CPPFlags = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:JavaFlags = 'javac\ %'

func! s:RunWith (command)
  execute "w"
  exe ":ccl"
  " clean是在linux下的命令
"  execute "!clear;time " . a:command . " " . expand("%")
  execute "AsyncRun " . a:command . " " . expand("%")
endfunction

func! Compile()
    exe ":ccl"
    exe ":update"
    let s:Sou_Error = 0
    let s:LastShellReturn_C = 0
    let Sou = expand("%:p")
    let v:statusmsg = ''
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        let Obj_Name = expand("%:p:t:r").s:Obj_Extension
        if !filereadable(Obj) || (filereadable(Obj) && (getftime(Obj) < getftime(Sou)))
            redraw!
            if expand("%:e") == "c"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CFlags
                else
                    exe ":setlocal makeprg=".s:linux_CFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                if g:iswindows
                    exe ":setlocal makeprg=".s:windows_CPPFlags
                else
                    exe ":setlocal makeprg=".s:linux_CPPFlags
                endif
                echohl WarningMsg | echo " compiling..."
                silent make
            endif
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""Obj_Name"is up to date"
        endif
    elseif expand("%:e") == "java"
        let class = expand("%:p:r").s:Class_Extension
        let class_Name = expand("%:p:t:r").s:Class_Extension
        if !filereadable(class) || (filereadable(class) && (getftime(class) < getftime(Sou)))
            redraw!
            exe ":setlocal makeprg=".s:JavaFlags
            echohl WarningMsg | echo " compiling..."
            silent make
            redraw!
            if v:shell_error != 0
                let s:LastShellReturn_C = v:shell_error
            endif
            if g:iswindows
                if s:LastShellReturn_C != 0
                    exe ":bo cope"
                    echohl WarningMsg | echo " compilation failed"
                else
                    if s:ShowWarning
                        exe ":bo cw"
                    endif
                    echohl WarningMsg | echo " compilation successful"
                endif
            else
                if empty(v:statusmsg)
                    echohl WarningMsg | echo " compilation successful"
                else
                    exe ":bo cope"
                endif
            endif
        else
            echohl WarningMsg | echo ""class_Name"is up to date"
        endif
    else
        let s:Sou_Error = 1
        echohl WarningMsg | echo " please choose the correct source file"
    endif
    exe ":setlocal makeprg=make"
endfunc

func! Link()
    call Compile()
    if s:Sou_Error || s:LastShellReturn_C != 0
        return
    endif
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let s:LastShellReturn_L = 0
        let Sou = expand("%:p")
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
            let Exe_Name = expand("%:p:t:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
            let Exe_Name = expand("%:p:t:r")
        endif
        let v:statusmsg = ''
        if filereadable(Obj) && (getftime(Obj) >= getftime(Sou))
            redraw!
            if !executable(Exe) || (executable(Exe) && getftime(Exe) < getftime(Obj))
                if expand("%:e") == "c"
                    setlocal makeprg=gcc\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                elseif expand("%:e") == "cpp" || expand("%:e") == "cxx"
                    setlocal makeprg=g++\ -o\ %<\ %<.o
                    echohl WarningMsg | echo " linking..."
                    silent make
                endif
                redraw!
                if v:shell_error != 0
                    let s:LastShellReturn_L = v:shell_error
                endif
                if g:iswindows
                    if s:LastShellReturn_L != 0
                        exe ":bo cope"
                        echohl WarningMsg | echo " linking failed"
                    else
                        if s:ShowWarning
                            exe ":bo cw"
                        endif
                        echohl WarningMsg | echo " linking successful"
                    endif
                else
                    if empty(v:statusmsg)
                        echohl WarningMsg | echo " linking successful"
                    else
                        exe ":bo cope"
                    endif
                endif
            else
                echohl WarningMsg | echo ""Exe_Name"is up to date"
            endif
        endif
        setlocal makeprg=make
    elseif expand("%:e") == "java"
        return
    endif
endfunc

func! <SID>async_run()
" 不需要编译的解释型脚本语言
    "python默认为python3
    if expand("%:e") == "py"
        if g:islinux
            call s:RunWith("python3")
        else
            call s:RunWith("python")
        endif
        return
    elseif expand("%:e") == "html" || expand("%:e") == "html"
        if g:islinux
            call s:RunWith("firefox")
        else
            call s:RunWith(" D:\DevelopTool\ffdevelop\firefox.exe")
        endif
        return
    elseif expand("%:e") == "vbs"
        execute "w"
        exe ":ccl"
        execute "!" . expand("%")
        return
    endif
" 需要编译的语言。 C/C++/Java
    let s:ShowWarning = 0
    call Link()
    let s:ShowWarning = 1
    if s:Sou_Error || s:LastShellReturn_C != 0 || s:LastShellReturn_L != 0
        return
    endif
    let Sou = expand("%:p")
    if expand("%:e") == "c" || expand("%:e") == "cpp" || expand("%:e") == "cxx"
        let Obj = expand("%:p:r").s:Obj_Extension
        if g:iswindows
            let Exe = expand("%:p:r").s:Exe_Extension
        else
            let Exe = expand("%:p:r")
        endif
        if executable(Exe) && getftime(Exe) >= getftime(Obj) && getftime(Obj) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!%<.exe"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c './%<; echo; echo 请按 Enter 键继续; read'"
                else
                    exe ":!clear; ./%<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    elseif expand("%:e") == "java"
        let class = expand("%:p:r").s:Class_Extension
        if getftime(class) >= getftime(Sou)
            redraw!
            echohl WarningMsg | echo " running..."
            if g:iswindows
                exe ":!java %<"
            else
                if g:isGUI
                    exe ":!gnome-terminal -x bash -c 'java %<; echo; echo 请按 Enter 键继续; read'"
                else
                    exe ":!clear; java %<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    endif
endfunc

func! <SID>async_stoprun()
    execute "AsyncStop"
endfunc
"-----------------------------------------------------------------------------"

