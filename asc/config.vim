"======================================================================
"��������
"======================================================================
set foldenable                                        "�����۵�
set foldmethod=indent                                 "indent �۵���ʽ
set breakindent                                   "vim8�м���ĸ������ݱ�������
set matchpairs=(:),{:},[:],<:>   "ƥ�����ŵĹ���"

"======================================================================
"��ݼ�
"======================================================================
"�л�����
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
"�ֺŽ�������ģʽ
nnoremap ; :
"vwѡ�е�ǰ����
nmap vw viw
"Q��Qa�˳�
noremap Q q
noremap Qa qa

" �ÿո���������۵�
"  <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" ��������
" set guifont=YaHei\ Consolas\ Hybrid\ 12

"��겻��˸
set gcr=a:block-blinkon0

"======================================================================
" ƽ̨�������
"======================================================================
if g:islinux
    set guifont=Source\ Code\ Pro\ Bold\ 11
    "fix webpack-hot-reload not work in linux
    set backupcopy=yes
endif


