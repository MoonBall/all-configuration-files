set nocompatible

let hasVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    let hasVundle=0
endif

" Vundle begin
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'tpope/vim-surround'
Plugin 'altercation/vim-colors-solarized'
Plugin 'sbdchd/neoformat'                     " yarn global add prettier, 检查 prettier 命令是否存在(安装成功
Plugin 'w0rp/ale'                             " 需要 eslint, devDependencies

call vundle#end()            " required
filetype plugin indent on    " required

if hasVundle == 0
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
    :quit	" 关闭 PluginInstall 界面
endif
" Vundle end

" 否则不能向左删除空格
set backspace=2

" 在右下角显示光标所在行列、百分比
set ru
" 状态栏在任何时候打开，默认在 split window 后才显示
set laststatus=2

" 语法高亮
syntax on
filetype on
filetype plugin on

" 搜索相关
set hls
set incsearch

" 设置主题
" let g:solarized_termcolors=256
" set background=dark
" colorscheme solarized
colorscheme desert

" 为光标所在行加下划线
set cursorline 
" 代码位置会影响是否设置成功, 且该设置会覆盖 cursorline
" hi CursorLine   cterm=NONE ctermbg=52 ctermfg=NONE

" 数字设置为十进制，否则 007 为八进制
set nrformats=

" zsh 模式补全 tab，否则无列表，按 tab 切换
set wildmenu
set wildmode=full

" 显示行号
set number

" 缩进相关
set shiftwidth=2 softtabstop=2 expandtab
set nocindent
set nosmartindent
set autoindent

set autoread                        " set to auto read when a file changed from the outside

" 80 字符
set colorcolumn=81

" 为 find 命令提供搜索路径
set path+=$PWD/src/**,$PWD/**

" gf 文件跳转添加后缀
set suffixesadd=.js

" 缓存区在未保存时仍可切换，利于 *.do 命令运行
" set hidden

" 关闭高亮功能的快捷键
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" 映射相对于活动缓冲区的路径
cnoremap <expr> %% getcmdtype( ) == ':' ? expand('%:h').'/' : '%%'

" javascriptcomplete#CompleteJS 会开启 cindent 
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS " | set nocindent

" prettier 
autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --parser\ flow\ --single-quote\ --trailing-comma\ es5
let g:neoformat_try_formatprg = 1

autocmd BufWritePre *.js Neoformat            " prettier
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" 启动时执行 NERDTree；如果有参数则活动窗口在右边，否则活动在 NERDTree
" Vim 启动时 NERDTree 有三种情况：
" 1. 进入一个目录，NERDTree 应该是对目录的 BufEnter 进行了拦截，在该目录所在
" window 进行选择，不会新开一个 window。
" 2. 进入一个普通文件，使用 NERDTreeFind 找到文件对应位置
" 3. 进入一个不存在的文件，使用 NERDTree 展示 pwd
" TabNew 时 NERDTree 有两种情况：
" 1. 目标是文件，为了获取 expand('%:p'),
"     如果文件在 buffer 中，监听 BufEnter (因为此时不执行 BufReadPost)；
"     否则监听 BufReadPost (因为此时 BufEnter 拿不到值)
" 2. 目标是目录，需要在 BufEnter 执行, BufReadPost 不会执行
function GangNERDTreeLocation(path)
  if a:path == ''                             " [No Name] buffer
    NERDTree
  else
    if isdirectory(a:path)                    " 目录，展示它
      NERDTree
      wincmd p
    elseif filereadable(a:path)               " 文件，定位它
      NERDTreeFind
      wincmd p
    else
      NERDTree                                " 不存在的文件, 但是指定了文件名，可能新增文件，所以激活 buffer
      wincmd p
    endif
  endif
endfunction

function GangVimEnterNERDTree()
  let t:gangc_tab_new_nerdtree_flag = 2
  let l:argv0 = argc() == 0 ? '' : argv()[0]
  call GangNERDTreeLocation(l:argv0)
endfunction

" Tab 第一次进入的时候才会去 NERDTreeFind，设置标志位
function GangTabEnterNERDTreeFlag()
  if !exists("t:gangc_tab_new_nerdtree_flag")
    let t:gangc_tab_new_nerdtree_flag = 1
  endif
endfunction

function GangTabEnterNERDTree()
  if !exists("t:gangc_tab_new_nerdtree_flag") || t:gangc_tab_new_nerdtree_flag != 1
    return
  endif
  " 只执行一次
  let t:gangc_tab_new_nerdtree_flag = 2

  call GangNERDTreeLocation(expand('%:p'))
endfunction
  
function GangTabLeaveNERDTree()
  " 尝试切走，如果还是 NERDTree，在切回去
  if exists("b:NERDTree")
    wincmd p
    if exists("b:NERDTree")
      wincmd p
    endif
  endif
endfunction

" BufEnter 在 VimEnter 之前执行，但在 TabEnter 之后执行
" 每次 tab 离开不让 active buffer 在 NERDTree 上，为了 tab 标签的展示
" 新建 tab 时，像启动 vim 时一样定位
autocmd VimEnter * call GangVimEnterNERDTree()
autocmd TabLeave * call GangTabLeaveNERDTree()
autocmd TabEnter * call GangTabEnterNERDTreeFlag()
autocmd BufEnter * if isdirectory(expand('%:p')) || filereadable(expand('%:p')) | call GangTabEnterNERDTree() | endif
autocmd BufReadPost * if filereadable(expand('%:p')) | call GangTabEnterNERDTree() | endif

let NERDTreeShowHidden=1
let NERDTreeIgnore=['^\.git$[[dir]]', '\.idea$[[dir]]', '\.DS_Store$', '\.swp$'] " 只能匹配 item 名，比如 ^\.git$
" let NERDTreeRespectWildIgnore=1
" set wildignore+=*node_modules/.bin*,*node_modules/.cache*,*node_modules/.hooks* " 可考虑使用 ctrlP 插件

" 设置mapleader
" let mapleader="'"

" <silent> 命令行不回显命令；:silent 不回显命令的输出信息，但是会显示错误
nnoremap <silent> <leader>r <C-[>:<C-u>silent NERDTreeFind<CR>
nnoremap <silent> <leader>f <C-[>:<C-u>silent NERDTreeToggle<CR>
nnoremap <leader>q :<C-u>qa<CR>

" 粘贴相关，centos 没有 +/* 的寄存器
set pastetoggle=<F2>
map <leader>t "+y
vmap <leader>x "+ygvd
map <leader>v "+p
map <leader>V "+P

" 路径补全：相对当前文件路径、模块名
imap <C-x><C-r> <C-o>:cd %:h<CR><C-x><C-f>
imap <C-x><C-m> <C-o>:cd $PWD/node_modules<CR><C-x><C-f>
vmap gt "ty:<C-u>tabfind <C-r>t<CR>

" NERD Commenter：注释后添加一个空格
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'

" 缩进线设置，indentLine 有性能问题，还是使用 indent_guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd vimenter * :hi IndentGuidesOdd ctermbg=238
autocmd vimenter * :hi IndentGuidesEven ctermbg=241
let g:indent_guides_exclude_filetypes = ['nerdtree']
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
set nowrap " 不换行，缩进才好看

" 一些 vim 问题
" 1. 行尾 ^M 字符解决方案：%s/\r//g。http://blog.csdn.net/zhangguangyi888/article/details/8159601

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
 au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

let g:ale_linters = {
\   'javascript': ['eslint'],
\}
let g:ale_lint_on_enter = 0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" 总是展示 tabs 避免闪动
set showtabline=2

