" OFF highlight    :noh

set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set nocompatible               
filetype off                   
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
 
" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tomasr/molokai'
Bundle 'tpope/vim-rails.git'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-powerline'
Bundle 'eugeii/consolas-powerline-vim'

Bundle 'Color-Sampler-Pack'
Bundle 'STL-improved'                                    
Bundle 'majutsushi/tagbar'                              
Bundle 'tczengming/autoload_cscope.vim'                  
Bundle 'CmdlineComplete'
"  Ultimate auto completion system for Vim
Bundle 'neocomplcache'
Bundle 'genutils'
Bundle 'lookupfile'
" Preview the definition of variables or functions in a preview window
Bundle 'autopreview'
" Echo the function declaration in the command line for C/C++
Bundle 'echofunc.vim'
Bundle 'grep.vim'
Bundle 'a.vim'
" Under linux need exec 'dos2unix
" ~/.vim/bundle/QFixToggle/plugin/qfixtoggle.vim'
Bundle 'QFixToggle'
" manage Most Recently Used (MRU) files
Bundle 'mru.vim'
Bundle 'tczengming/headerGatesAdd.vim'
"Bundle 'ShowMarks'
" Deal with pairs of punctuations such as (), [], {}, and so on
Bundle 'kana/vim-smartinput'
Bundle 'minibufexpl.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'Xuyuanp/nerdtree-git-plugin'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vundle end
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Brief help  -- 此处后面都是vundle的使用命令
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" solarized theme
 set t_Co=256                " Explicitly tell vim that the terminal supports
" 256 colors, need before setting the colorscheme
" let g:solarized_termcolors=256
" colorscheme solarized
 colorscheme molokai 
" set background=dark
let g:rehash256 = 1
let g:molokai_original = 1

" Enable syntax highlighting
 syntax on

 set number
 set nrformats=
 set autochdir               " 自动切换当前目录为当前文件所在的目录

 " Set to auto read when a file is changed from the outside
 set autoread
 set hlsearch
 " vim-powerline
 set encoding=utf8
 set laststatus=2            " always have status-line'
 let g:Powerline_symbols = 'fancy'
" set statusline=%F%m%r%h%w\ %{&ff}\ %Y\ [ascii:%b\ hex:0x\%02.2B]\ [%{(&fenc\ ==\ \"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %=%l/%L,%v\ %p%%
 
" allow backspacing over everything in insert mode
 set backspace=indent,eol,start

 " 光标到达行尾或者行首时，特定键继续移动转至下一行或上一行
 set whichwrap+=b,s,<,>,[,]
 " Tab related
 set autoindent
 set cindent
 set shiftwidth=4
 set tabstop=4
 set softtabstop=4
"-----------------------------------------------------------------------
" Set ctags
"-----------------------------------------------------------------------
set tags =~/code/local/tags
"-----------------------------------------------------------------------
" Set MiniBufExplorer
"-----------------------------------------------------------------------
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:bufExplorerMaxHeight=30
let g:miniBufExplorerMoreThanOne=0
"-----------------------------------------------------------------------
" Set c/h swap press F12 
"-----------------------------------------------------------------------
nnoremap <silent> <F12> :A<CR>
"-----------------------------------------------------------------------
" Set Grep finder Press F3
"-----------------------------------------------------------------------
nnoremap <silent> <F3> :Grep<CR>
let Grep_Path = '/bin/grep'
"-----------------------------------------------------------------------
" Set tagbar
"-----------------------------------------------------------------------
let g:tagbar_width = 30
nmap <Leader>tb :TagbarToggle<CR>
let g:tagbar_ctags_bin='/usr/bin/ctags'
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
"-----------------------------------------------------------------------
" Set NERDTree option
" Auto change the root directory
"-----------------------------------------------------------------------
let NERDTreeChDirMode=2
let g:NERDTreeWinSize = 23
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
function! ToggleNERDTreeAndTagbar()
	let w:jumpbacktohere = 1
	" Detect which plugins are open
	if exists('t:NERDTreeBufName')
		let nerdtree_open = bufwinnr(t:NERDTreeBufName) != -1
	else
		let nerdtree_open = 0
	endif
	let tagbar_open = bufwinnr('__Tagbar__') != -1
	" Perform the appropriate action
	if nerdtree_open && tagbar_open
		NERDTreeClose
		TagbarClose
	elseif nerdtree_open
		TagbarOpen
	elseif tagbar_open
		NERDTree
	else
		NERDTree
		TagbarOpen
	endif
	" Jump back to the original window
	for window in range(1, winnr('$'))
		execute window . 'wincmd w'
		if exists('w:jumpbacktohere')
			unlet w:jumpbacktohere
			break
		endif
	endfor
endfunction
nmap :call ToggleNERDTreeAndTagbar()
"--------------------------------------------------------------------------
" Set cscope
"--------------------------------------------------------------------------
if has("cscope")
	set csprg=/usr/bin/cscope
	" Use both cscope and ctag
	set cscopetag
	" Show msg when cscope db added
	set cscopeverbose
	" Use cscope for definition search first
	set cscopetagorder=0
endif
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"---------------------------------------------------------------------------
" Set QuickFix
"---------------------------------------------------------------------------
set cscopequickfix=s-,c-,d-,i-,t-,e-
"---------------------------------------------------------------------------
" Setting lookupfile
"---------------------------------------------------------------------------
let g:LookupFile_MinPatLength = 2
let g:LookupFile_PreserveLastPattern = 0
let g:LookupFile_PreservePatternHistory = 1
let g:LookupFile_AlwaysAcceptFirst = 1
let g:LookupFile_AllowNewFiles = 0
if filereadable("/home/epstwxv/code/local/filenametags")
	let g:LookupFile_TagExpr = '"/home/epstwxv/code/local/filenametags"'
endif
nmap <C-l><C-k> :LUTags<cr>
nmap <C-l><C-l> :LUBufs<cr>
nmap <C-l><C-w> :LUWalk<cr>
