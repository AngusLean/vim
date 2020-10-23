if has("python") || has("python3")
    let g:plug_threads = 10
else
    let g:plug_threads = 1
endif

call plug#begin(g:vimrc_home.'/vimfiles/plugged')

"配置补全插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"匹配插件
" Plug 'exvim/ex-matchit'
"对齐线
" Plug 'Yggdroot/indentLine'
"自动括号插件
" Plug 'jiangmiao/auto-pairs'
"多光标选择输入插件.下面的第一个与neocpmplete冲突"
Plug  'kristijanhusak/vim-multiple-cursors'

"空白的特殊处理
Plug 'ntpeters/vim-better-whitespace'

"主题插件
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'

"多选
Plug 'tpope/vim-surround'

"左边文件浏览
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

"Ctrlp文件查找
Plug 'Yggdroot/LeaderF'

Plug 'majutsushi/tagbar'

"
"注释插件
Plug 'scrooloose/nerdcommenter'

"Plug 'chemzqm/mycomment.vim'
"
" 状态栏
Plug 'itchyny/lightline.vim'

"文本对齐插件
Plug 'godlygeek/tabular'

"大文件处理
Plug 'vim-scripts/LargeFile'

"代码片段
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

"代码格式化
" Plug 'Chiel92/vim-autoformat'

"JavaScript doc syntax
"Plug 'othree/jsdoc-syntax.vim', { 'for': 'javascript' }
"Plug 'maksimr/vim-jsbeautify'

"更好用的javascript语法高亮插件
" Plug 'othree/yajs.vim', { 'for': 'javascript' }
" Plug 'mxw/vim-jsx'
" Plug 'chemzqm/vim-jsx-improve'
"Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
" Plug 'HerringtonDarkholme/yats.vim', { 'for': 'javascript' }
" Plug 'mhartington/nvim-typescript', { 'for': 'javascript' }

Plug 'mattn/emmet-vim', { 'for': 'html,vue' }
" Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'posva/vim-vue', { 'for': 'html,vue' }

" Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

Plug 'Vimjas/vim-python-pep8-indent',{'for': 'python'}


"右侧辅助菜单
" Plug 'skywind3000/quickmenu.vim'
Plug 'skywind3000/vim-quickui'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

"语法检查插件
" Plug 'w0rp/ale'
" Plug 'dyng/ctrlsf.vim'

"启动画面处理
Plug 'mhinz/vim-startify'
" Plug 'vim-scripts/DrawIt'
Plug 'ludovicchabant/vim-gutentags'
Plug 'voldikss/vim-floaterm'
call plug#end()
