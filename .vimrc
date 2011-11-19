" <Vundle settings>
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Align'
Bundle 'neocomplcache'
Bundle 'quickrun.vim'
Bundle 'ZenCoding.vim'
Bundle 'motemen/hatena-vim'
Bundle 'The-NERD-Commenter'
Bundle 'AutoClose'
Bundle 'motemen/git-vim'
Bundle 'surround.vim'
Bundle 'Markdown-syntax'
Bundle 'Gist.vim'

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

" http://d.hatena.ne.jp/tanakaBox/20070609/1181382818
aug Scheme
  au!
  au Filetype scheme setl cindent& lispwords=define
aug END

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

autocmd FileType make setlocal noexpandtab

" <functions>
" === 行末のスペースを削除 ===
" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge

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

" === Shebang がある時に実行権限を自動付与===
autocmd BufWritePost * :call AddExecmod()

function AddExecmod()
    let line = getline(1)
    if strpart(line, 0, 2) == "#!"
        call system("chmod +x ". expand("%"))
    endif
endfunction

