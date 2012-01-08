if has ('mac')
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
  Bundle 'Shougo/unite.vim'
  Bundle 'h1mesuke/unite-outline'
  Bundle 'basyura/unite-yarm'
  Bundle 'mattn/webapi-vim'
  Bundle 'tyru/open-browser.vim'
  Bundle 'ujihisa/neco-look'

  filetype plugin indent on     " required!

  " <plugins>
  " <neocomplcache>
  let g:neocomplcache_enable_at_startup          = 1

  " 起動時に有効化 Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Use camel case completion.
  let g:neocomplcache_enable_camel_case_completion = 1
  " Use underbar completion.
  let g:neocomplcache_enable_underbar_completion = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
	  let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  imap <C-k>     <Plug>(neocomplcache_snippets_expand)
  smap <C-k>     <Plug>(neocomplcache_snippets_expand)
  inoremap <expr><C-g>     neocomplcache#undo_completion()
  inoremap <expr><C-l>     neocomplcache#complete_common_string()

  " SuperTab like snippets behavior.
  imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()

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

  " <Hatena mode>
  set runtimepath+=~/.vim/bundle/hatena-vim
  let g:hatena_user='sirocco634'

  " <Unite Yet Another Redmine Mode>
  let g:unite_yarm_server_url = 'http://192.168.11.38/redmine/'
  let g:unite_yarm_access_key = 'e1724f8f64f3a69787da8121ed85ac4319999754'
  let g:unite_yarm_limit = 50
  let g:unite_yarm_backup_dir = '/tmp/yarm'
endif

" <misc>
syntax on
filetype on
filetype indent on
filetype plugin on
:colorscheme murphy
set list
set listchars=trail:_,tab:>-

" <gauche>
autocmd FileType scheme :let is_gauche=1

" http://d.hatena.ne.jp/tanakaBox/20070609/1181382818
aug Scheme
  au!
  au Filetype scheme setl cindent& lispwords=define,lambda
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
:nnoremap j gj
:nnoremap k gk
:nnoremap <Down> gj
:nnoremap <Up>   gk

" <display>
set showmatch         " 括弧の対応をハイライト
set number            " 行番号表示

" <statusline>
let g:gitCurrentBranch = ''
function! CurrentGitBranch()
    let cwd = getcwd()
    cd %:p:h
    let branch = matchlist(system('/usr/bin/env git branch -a --no-color'), '\v\* ([0-9A-Za-z\/]*)\r?\n')
    execute 'cd ' . cwd
    if (len(branch))
      let g:gitCurrentBranch = '[git:' . branch[1] . ']'
    else
      let g:gitCurrentBranch = ''
    endif
    return g:gitCurrentBranch
endfunction

autocmd BufEnter * :call CurrentGitBranch()

set laststatus=2
" ステータスラインの表示
set statusline=%<     " 行が長すぎるときに切り詰める位置
set statusline+=[%n]  " バッファ番号
set statusline+=%m    " %m 修正フラグ
set statusline+=%r    " %r 読み込み専用フラグ
set statusline+=%h    " %h ヘルプバッファフラグ
set statusline+=%w    " %w プレビューウィンドウフラグ
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
set statusline+=%y    " バッファ内のファイルのタイプ
set statusline+=\     " 空白スペース
if winwidth(0) >= 130
  set statusline+=%F    " バッファ内のファイルのフルパス
else
  set statusline+=%t    " ファイル名のみ
endif
set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
set statusline+=%{g:gitCurrentBranch} " Gitのブランチ名を表示
set statusline+=\ \   " 空白スペース2個
set statusline+=%1l   " 何行目にカーソルがあるか
set statusline+=/
set statusline+=%L    " バッファ内の総行数
set statusline+=,
set statusline+=%c    " 何列目にカーソルがあるか
set statusline+=%V    " 画面上の何列目にカーソルがあるか
set statusline+=\ \   " 空白スペース2個
set statusline+=%P    " ファイル内の何％の位置にあるか

" <indent>
set tabstop=4
set expandtab     " tab をスペースに展開
set shiftwidth=2  " 自動インデントの幅
set softtabstop=4

autocmd FileType make setlocal noexpandtab

" Undo highlights of the search results, when push ESC + ESC
:nnoremap <Esc><Esc> :nohlsearch<CR>

" 横分割時は下へ､ 縦分割時は右へ新しいウィンドウが開くようにする
set splitbelow
set splitright

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

" === change the current directory ===
augroup grlcd
  autocmd!
  autocmd BufEnter * lcd %:p:h
augroup END

" === Invole copen command when vimgrep or so
if has('mac')
  augroup grepopen
    autocmd!
    autocmd QuickFixCmdPo vimgrep cwindow
  augroup END
endif

" === template ===
if has('mac')
  augroup templateload
    autocmd!
    autocmd BufNewFile *.sh 0r ~/.vim/template/skelton.sh
    autocmd BufNewFile *.pl 0r ~/.vim/template/skelton.pl
    autocmd BufNewFile *.scm 0r ~/.vim/template/skelton.scm
  augroup END
endif

