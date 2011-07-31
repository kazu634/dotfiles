" <Vundle settings>
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Align'
Bundle 'neocomplcache'
Bundle 'unite.vim'
Bundle 'quickrun.vim'
Bundle 'ZenCoding.vim'
Bundle 'motemen/hatena-vim'
Bundle 'The-NERD-Commenter'
Bundle 'AutoClose'
Bundle 'motemen/git-vim'

filetype plugin indent on     " required!

" <plugins>
" neocomplcache
let g:neocomplcache_enable_at_startup          = 1 " 起動時に有効化
let g:neocomplcache_enable_auto_select         = 1
let g:neocomplcache_enable_smart_case          = 1
let g:neocomplcache_enable_underbar_completion = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" オムニ補完
if !exists('g:NeoComplCache_OmniPatterns')
    let g:NeoComplCache_OmniPatterns = {}
endif

" unite.vim
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" Hatena mode
set runtimepath+=~/.vim/bundle/hatena-vim
let g:hatena_user='sirocco634'

" <misc>
syntax on
filetype on
filetype indent on
filetype plugin on
:colorscheme murphy

" <gauche>
autocmd FileType scheme :let is_gauche=1

" <encoding>
set encoding=utf-8

" <basic>
let mapleader = ","            " キーマップリーダー
set nobackup                   " バックアップ取らない
set hidden                     " 編集中でも他のファイルを開けるようにする
set formatoptions=lmoq         " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                   " ビープをならさない
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set autoread                   " 他で書き換えられたら自動で読み直す
set whichwrap=b,s,h,l,<,>,[,]  " カーソルを行頭、行末で止まらないようにする
set scrolloff=5                " スクロール時の余白確保

"カーソルを表示行で移動する。物理行移動は<C-n>,<C-p>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" <display>
set showmatch         " 括弧の対応をハイライト
set number            " 行番号表示

" <indent>
set tabstop=4
set expandtab     " tab をスペースに展開
set shiftwidth=2  " 自動インデントの幅
set softtabstop=4

" <functions>
" === 行末のスペースを削除 ===
" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/  /ge

" === カーソル行をハイライト ===
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" === junkフォルダに一時ファイルを作成 ===
function! GenerateFileName()
  let now = localtime()
  let extention = input("Extention?: ")
  let filename =  strftime("%Y-%m-%d-%H%M%S", now) . "." . extention
  return "/Users/kazu634/junk/" . filename
endfunction

command! EditTemporaryFile :edit `=GenerateFileName()`

