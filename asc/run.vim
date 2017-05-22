"-----------------------------------------------------------------------------"
" -----------------------------------------------------------------------------
"  < ���롢���ӡ��������� (Ŀǰֻ������C��C++��Java����)>
" -----------------------------------------------------------------------------

"autocmd FileType python nmap <F6> :call RunWith("py -3")<cr>

" F9 һ�����桢���롢���Ӵ沢����
nmap <F9> :call Run()<CR>
imap <F9> <ESC>:call Run()<CR>

" Ctrl + F9 һ�����沢����
nmap <c-F9> :call Compile()<CR>
imap <c-F9> <ESC>:call Compile()<CR>

" Ctrl + F10 һ�����沢����
nmap <c-F10> :call Link()<CR>
imap <c-F10> <ESC>:call Link()<CR>

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

function RunWith (command)
  execute "w"
  exe ":ccl"
  " clean����linux�µ�����
"  execute "!clear;time " . a:command . " " . expand("%")
  execute "!" . a:command . " " . expand("%")
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

func! Run()
" ����Ҫ����Ľ����ͽű�����
    "pythonĬ��Ϊpython3
    if expand("%:e") == "py"
        call RunWith("py -3")
        return
    elseif expand("%:e") == 'vbs'
        execute "w"
        exe ":ccl"
        execute "!" . expand("%")
        return
    endif
" ��Ҫ��������ԡ� C/C++/Java
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
                    exe ":!gnome-terminal -x bash -c './%<; echo; echo �밴 Enter ������; read'"
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
                    exe ":!gnome-terminal -x bash -c 'java %<; echo; echo �밴 Enter ������; read'"
                else
                    exe ":!clear; java %<"
                endif
            endif
            redraw!
            echohl WarningMsg | echo " running finish"
        endif
    endif
endfunc
"-----------------------------------------------------------------------------"


" -----------------------------------------------------------------------------
"  < ���������Ԥ�� Html �� PHP �ļ� >
" -----------------------------------------------------------------------------
" �޸�ǰ����ͨ����ģ�飬�������ٸ��Ա������

" F5 �������������д���������Ԥ��������ǰ��ȷ���а�װ��Ӧ�������������������ú��䰲װĿ¼
if g:iswindows
    "����Ϊֻ֧��Windowsϵͳ�������

    " ����ϵͳIE�����Ԥ���������ж�ؿɽ���ע��
    nmap <F5>ie :call ViewInBrowser("ie")<cr>
    imap <F5>ie <ESC>:call ViewInBrowser("ie")<cr>

    " ����IETester(IE���Թ���)Ԥ��������а�װ��ȡ��ע��
    " nmap <F5>ie6 :call ViewInBrowser("ie6")<cr>
    " imap <F5>ie6 <ESC>:call ViewInBrowser("ie6")<cr>
    " nmap <F5>ie7 :call ViewInBrowser("ie7")<cr>
    " imap <F5>ie7 <ESC>:call ViewInBrowser("ie7")<cr>
    " nmap <F5>ie8 :call ViewInBrowser("ie8")<cr>
    " imap <F5>ie8 <ESC>:call ViewInBrowser("ie8")<cr>
    " nmap <F5>ie9 :call ViewInBrowser("ie9")<cr>
    " imap <F5>ie9 <ESC>:call ViewInBrowser("ie9")<cr>
    " nmap <F5>ie10 :call ViewInBrowser("ie10")<cr>
    " imap <F5>ie10 <ESC>:call ViewInBrowser("ie10")<cr>
    " nmap <F5>iea :call ViewInBrowser("iea")<cr>
    " imap <F5>iea <ESC>:call ViewInBrowser("iea")<cr>
elseif g:islinux
    "����Ϊֻ֧��Linuxϵͳ�������
    "��δ���ã�����ʱ����Ū��
endif

"����Ϊ֧��Windows��Linuxϵͳ�������

" ����Firefox�����Ԥ��������а�װ��ȡ��ע��
nmap <F5>ff :call ViewInBrowser("ff")<cr>
imap <F5>ff <ESC>:call ViewInBrowser("ff")<cr>

" ����Maxthon(����)�����Ԥ��������а�װ��ȡ��ע��
" nmap <F5>ay :call ViewInBrowser("ay")<cr>
" imap <F5>ay <ESC>:call ViewInBrowser("ay")<cr>

" ����Opera�����Ԥ��������а�װ��ȡ��ע��
" nmap <F5>op :call ViewInBrowser("op")<cr>
" imap <F5>op <ESC>:call ViewInBrowser("op")<cr>

" ����Chrome�����Ԥ��������а�װ��ȡ��ע��
" nmap <F5>cr :call ViewInBrowser("cr")<cr>
" imap <F5>cr <ESC>:call ViewInBrowser("cr")<cr>

" ��������ú���
function! ViewInBrowser(name)
    if expand("%:e") == "php" || expand("%:e") == "html"
        exe ":update"
        if g:iswindows
            "��ȡҪԤ�����ļ�·��������·���е�'\'�滻Ϊ'/'��ͬʱ��·�����ֵı���ת��Ϊgbk��ͬcp936��
            let file = iconv(substitute(expand("%:p"), '\', '/', "g"), "utf-8", "gbk")

            "�����·�����ã�·����ʹ��'/'б�ܣ�����·�������˫�����������
            "����ֻ������ϵͳIE��������������������Ŀɽ���ȡ��ע�ͣ����Ȱ�װ�������úð�װ·������Ҳ�ɰ�������
            let SystemIE = "C:/progra~1/intern~1/iexplore.exe"  "ϵͳ�Դ�IEĿ¼
            " let IETester = "F:/IETester/IETester.exe"           "IETester����Ŀ¼���ɰ�ʵ�ʸ��ģ�
            " let Chrome = "F:/Chrome/Chrome.exe"                 "Chrome����Ŀ¼���ɰ�ʵ�ʸ��ģ�
            let Firefox = "D:/DevelopTool/ffdevelop/firefox.exe"              "Firefox����Ŀ¼���ɰ�ʵ�ʸ��ģ�
            " let Opera = "F:/Opera/opera.exe"                    "Opera����Ŀ¼���ɰ�ʵ�ʸ��ģ�
            " let Maxthon = "C:/Progra~2/Maxthon/Bin/Maxthon.exe" "Maxthon����Ŀ¼���ɰ�ʵ�ʸ��ģ�

            "����������������ã��Ҳ��Ե���phpStudy2014���ɸ����Լ����޸ģ�����·�������˫�����������
            let htdocs ="F:/phpStudy2014/WWW/"                  "�����������ַ��Ŀ¼���ɰ�ʵ�ʸ��ģ�
            let url = "localhost"                               "�����������ַ���ɰ�ʵ�ʸ��ģ�
        elseif g:islinux
            "��ʱ��û�����ã���ʱ����Ū�ˡ�
        endif

        "�����������д���ɸ���ʵ��������ע�⣬���������·����û�ж�����ı������Ⱥ��ұ�Ϊ���������ܳ���������Ӵ���ɽ���ע�ͻ�ɾ����
        let l:browsers = {}                             "������д�ֵ���������в���ɾ����ע��
        " let l:browsers["cr"] = Chrome                   "Chrome�������д
        let l:browsers["ff"] = Firefox                  "Firefox�������д
        " let l:browsers["op"] = Opera                    "Opera�������д
        " let l:browsers["ay"] = Maxthon                  "�����������д
        let l:browsers["ie"] = SystemIE                 "ϵͳIE�������д
        " let l:browsers["ie6"] = IETester."-ie6"         "����IETESTER������IE6Ԥ����д�������Ӳ�����
        " let l:browsers["ie7"] = IETester."-ie7"         "����IETESTER������IE7Ԥ����д�������Ӳ�����
        " let l:browsers["ie8"] = IETester."-ie8"         "����IETESTER������IE8Ԥ����д�������Ӳ�����
        " let l:browsers["ie9"] = IETester."-ie9"         "����IETESTER������IE9Ԥ����д�������Ӳ�����
        " let l:browsers["ie10"] = IETester."-ie10"       "����IETESTER������IE10Ԥ����д�������Ӳ�����
        " let l:browsers["iea"] = IETester."-al"          "����IETESTER������֧�ֵ�����IE�汾Ԥ����д�������Ӳ�����

        if stridx(file, htdocs) == -1   "�ļ����ڱ������������Ŀ¼����ֱ��Ԥ���������ܽ���PHP�ļ���
           exec ":silent !start ". l:browsers[a:name] ." file://" . file
        else    "�ļ��ڱ������������Ŀ¼������ñ����������������Ԥ�������������������������
            let file = substitute(file, htdocs, "http://".url."/", "g")    "ת���ļ�·��Ϊ�����������ַ·��
            exec ":silent !start ". l:browsers[a:name] file
        endif
    else
        echohl WarningMsg | echo " please choose the correct source file"
    endif
endfunction
