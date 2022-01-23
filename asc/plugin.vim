if has("python") || has("python3")
    let g:plug_threads = 10
else
    let g:plug_threads = 1
endif

call plug#begin(g:vimrc_home.'/vimfiles/plugged')

" "配置补全插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"对齐线
Plug 'andymass/vim-matchup'

"自动括号插件
Plug 'jiangmiao/auto-pairs'
"多光标选择输入插件.下面的第一个与neocpmplete冲突"
Plug  'kristijanhusak/vim-multiple-cursors'

"空白的特殊处理
Plug 'ntpeters/vim-better-whitespace'

"主题插件
" Plug 'altercation/vim-colors-solarized'
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


"右侧辅助菜单
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/vim-quickui'


"启动画面处理
Plug 'mhinz/vim-startify'
" Plug 'vim-scripts/DrawIt'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'voldikss/vim-floaterm'

" Plug 'puremourning/vimspector'

" Plug 'skywind3000/gutentags_plus'

call plug#end()
