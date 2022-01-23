a personal vimrc config

## Install
1. install python3, eg: python3.8
2. install [rg]{https://github.com/BurntSushi/ripgrep#installation} 
3. install gvim
4. put this config in $USER/_vimrc
```
set pythonthreedll=D:/software/python3.8/python38.dll
let $PATH .= ';D:\software\python3.8\python.exe;D:\software\python3.8\Scripts'
so D:\mimeproject\vim\.vimrc
let g:startify_bookmarks = [ {'vim': 'D:/mimeproject/vim/.vimrc'}  ]
```