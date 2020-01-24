"不要使用vi的键盘模式，而是vim自己的"
set nocompatible
"打开文件类型检测"
filetype plugin indent on
"允许插件"
filetype plugin on

call plug#begin('~/AppData/Local/nvim/plugged')
"自动补全"
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"自动引号括号补全"
Plug 'jiangmiao/auto-pairs'
"注释插件/cc/cu"
Plug 'scrooloose/nerdcommenter'
"代码自动 format 插件"
Plug 'sbdchd/neoformat'
"文件管理器"
Plug 'scrooloose/nerdtree'
"代码检查工具"
Plug 'neomake/neomake'
"多点编辑"
Plug 'terryma/vim-multiple-cursors'
"高亮显示复制区域"
Plug 'machakann/vim-highlightedyank'
"代码折叠插件zo zc"
"Plug 'tmhedberg/SimpylFold'"
"Vim某一颜色主题"
"Plug 'morhetz/gruvbox'"
"Plug 'junegunn/seoul256.vim'"
Plug 'joshdick/onedark.vim'
"符号对齐"
Plug 'junegunn/vim-easy-align'
"HTML"
Plug 'mattn/emmet-vim'

"Plug 'numirias/semshi', {'do' : ':UpdateRemotePlugins'}"
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

"let g:deoplete#enable_at_startup = 1"

"Python插件"
let g:python3_host_prog='C:/Users/wuxi/Envs/neovim3/Scripts/python.exe'
let g:python3_host_prog='C:/Users/wuxi/Envs/neovim3/Scripts/python.exe'

let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_docstring=1
let b:SimpylFold_fold_docstring=1
let g:SimpylFold_fold_import=1
let b:SimpylFold_fold_import=1
"关于状态栏的小配置"
let g:airline_powerline_fonts = 1

"设置编码"
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
"显示行号"
set nu
"突出显示当前行"
set cul
"启用鼠标"
set mouse=a
set selection=exclusive
set selectmode=mouse,key
"显示括号匹配" "匹配括号高亮的时间/0.1秒"
set showmatch
set matchtime=1
"设置缩进"
"设置Tab长度为4空格" "设置自动缩进长度为4空格" "继承前一行的缩进方式，适用于多行注释"
set tabstop=4
set shiftwidth=4
set autoindent
set cindent
"不要用空格代替制表符" 
set noexpandtab
"在行和段开始处使用制表符"
set smarttab
"设置粘贴模式"
set paste
"显示状态栏和光标当前位置"
set laststatus=2
"命令行（在状态行下）的高度，默认为1，这里是2"
set cmdheight=2
set ruler
"不显示那个援助乌干达儿童的提示"
set shortmess=atI
"允许折叠"
set foldenable
"语法高亮"
set syntax=on
"去掉输入错误的提示声音"
set noeb
"背景颜色"
set background=dark
"set background=light"
"显示颜色"
set t_Co=256
"设置当文件被改动时自动载入"
set autoread
"共享剪贴板"
set clipboard=unnamed
"不备份"  
set nobackup
set noswapfile
"设置魔术"
set magic
"历史记录数"
set history=1000
"搜索忽略大小写"
set ignorecase
"搜索逐字符高亮"
set hlsearch
set incsearch
"行内替换
set gdefault
"语言设置"
set langmenu=zh_CN.UTF-8
set helplang=cn
"带有如下符号的单词不要被换行分割"
set iskeyword+=_,$,@,%,#,-
"字符间插入的像素行数目"
set linespace=0
"增强模式中的命令行自动完成操作"
set wildmenu
"使回格键（backspace）正常处理indent, eol, start等"
set backspace=2
"允许backspace和光标键跨越行边界"
set whichwrap+=<,>,h,l
"通过使用: commands命令，告诉我们文件的哪一行被改变过"
set report=0
"在被分割的窗口间显示空白，便于阅读"
set fillchars=vert:\ ,stl:\ ,stlnc:\
"光标移动到buffer的顶部和底部时保持3行距离"
set scrolloff=3
"为C程序提供自动缩进"
set smartindent

"主题"
"colorscheme gruvbox"
colorscheme onedark

"键位的映射"
noremap T :NERDTree<CR>
noremap ,l :sp<CR><C-w>j:term ipython<CR> i %run 
noremap R :source ~/AppData/Local/nvim/init.vim<CR>
au filetype python noremap <f6> <C-w>k :only<CR>




"相对行号"
set relativenumber
augroup relative_numbser
 autocmd!
 autocmd InsertEnter * :set norelativenumber
 autocmd InsertLeave * :set relativenumber
augroup END

"==========================================================================================================================="
"一键运行代码"
function CheckPythonSyntax() 
    let mp = &makeprg 
    let ef = &errorformat 
    let exeFile = expand("%:t") 
    setlocal makeprg=python\ -u  
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m 
    silent make %
    copen 
"   set efm 是设置quickfix的errorformat，以便vim识别  
"  makeprg 是vim内置的编译命令，可以通过更改来实现编译对应类型文件。具体可参考vim官方说明文件。
"  copen是打开quickfix，n用来设置quichfix窗口大小，如 cope5。在错误描述上回车，可以直接跳转到错误行。
    let &makeprg     = mp  
    let &errorformat = ef  
endfunction

"一个是普通模式下，一个是插入模式下
au filetype python map <f5>  :w <cr> :call CheckPythonSyntax() <cr>
au filetype python imap <f5> <esc> :w <cr> :call CheckPythonSyntax() <cr></cr></cr></esc></f5></cr></cr></f5>


"PlugInstall"