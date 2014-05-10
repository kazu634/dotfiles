set nocompatible               " Be iMproved
filetype off                   " Required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch "Shougo/neobundle.vim"

" my bundles here:

NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neosnippet.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'quickrun.vim'
NeoBundle 'vim-scripts/sudo.vim'
NeoBundle 'tpope/vim-surround.git'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'AutoClose'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'honza/vim-snippets'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'OpsRockin/opscode_chef.vim_dict'
NeoBundle 'Shougo/neosnippet-snippets'

NeoBundle 'Shougo/vimproc.git', {
      \ 'build' : {
      \     'mac'     : 'make -f make_mac.mak',
      \     'unix'    : 'make -f make_unix.mak',
      \    },
      \ }

if has ('mac')
  NeoBundle 'motemen/hatena-vim'
  NeoBundle 'vim-scripts/VimRepress.git'
  NeoBundle 'mattn/gist-vim.git'
  NeoBundle 'mattn/webapi-vim.git'
endif

" -------------------------------------------------------------------------------
" <NeoComplcache>
" -------------------------------------------------------------------------------

" Disable AutoComplPop. Comment out this line if AutoComplPop is not installed.
" let g:acp_enableAtStartup = 0

" Launches neocomplcache automatically on vim startup.
let g:neocomplcache_enable_at_startup = 1

" Use smartcase.
let g:neocomplcache_enable_smart_case = 1

" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1

" Use underscore completion.
let g:neocomplcache_enable_underbar_completion = 1

" Sets minimum char length of syntax keyword.
let g:neocomplcache_min_syntax_length = 3

" buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define file-type dependent dictionaries.
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

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

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion. Not required if they are already set elsewhere in .vimrc
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion, which require computational power and may stall the vim.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c   = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'


" -------------------------------------------------------------------------------
" <NeoSnippet>
" -------------------------------------------------------------------------------

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets, ~/.vim/snippets'

" Load rspec.snip when loading rspec files
function! s:RSpecSnippet()
  NeoSnippetSource ~/.vim/snippets/serverspec.snip
endfunction

autocmd BufEnter *_spec.rb call s:RSpecSnippet()

" -------------------------------------------------------------------------------
" Quickrun
" -------------------------------------------------------------------------------

let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}

" -------------------------------------------------------------------------------
" <Hatena>
" -------------------------------------------------------------------------------

if has ('mac')
  set runtimepath+=~/.vim/bundle/hatena
  let g:hatena_user='sirocco634'
endif

" -------------------------------------------------------------------------------
" <smarchr>
" -------------------------------------------------------------------------------

inoremap <buffer><expr> = smartchr#loop('=', ' = ', ' => ', ' == ', " === ")
inoremap <buffer><expr> + smartchr#loop('+', ' + ', '++', ' += ')
inoremap <buffer><expr> - smartchr#loop('-', ' - ', '--', ' -= ')
inoremap <buffer><expr> / smartchr#loop('/', ' / ', '// ')
inoremap <buffer><expr> * smartchr#loop('*', ' * ')
inoremap <buffer><expr> < smartchr#loop('<', ' < ', ' << ', ' <= ')
inoremap <buffer><expr> > smartchr#loop('>', ' > ', ' >> ', ' >= ')
inoremap <buffer><expr> , smartchr#loop(', ', ',')

" -------------------------------------------------------------------------------
" <misc>
" -------------------------------------------------------------------------------

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
augroup templateload
  autocmd!
  autocmd BufNewFile *.sh      0r ~/.vim/template/skelton.sh
  autocmd BufNewFile *.pl      0r ~/.vim/template/skelton.pl
  autocmd BufNewFile *.scm     0r ~/.vim/template/skelton.scm
  autocmd BufNewFile test_*.rb 0r ~/.vim/template/skelton_test.rb
  autocmd BufNewFile *.rb      0r ~/.vim/template/skelton.rb
augroup END

" === IME ===

" 挿入モード終了時に IME 状態を保存しない
inoremap <silent> <Esc> <Esc>
inoremap <silent> <C-[> <Esc>

" 「日本語入力固定モード」切り替えキー
inoremap <silent> <C-j> <C-^>

" === indent-guide ===
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=LightBlue ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=4

" === simple-javascript-indenter ===
" shiftwidthを1にしてインデントしてくれる
let g:SimpleJsIndenter_BriefMode = 1
" この設定入れるとswitchのインデントがいくらかマシに
let g:SimpleJsIndenter_CaseIndentLevel = -1

" === highlight the string under the cursol ===
highlight CurrentWord cterm=underline ctermbg=NONE ctermfg=DarkMagenta

function! s:EscapeText( text )
  return substitute( escape(a:text, '\' . '^$.*[~'), "\n", '\\n', 'ge' )
endfunction

function! s:GetCurrentWord()
  let l:cword = expand('<cword>')
  if !empty(l:cword)
    let l:regexp = s:EscapeText(l:cword)
    if l:cword =~# '^\k\+$'
      let l:regexp = '\<' . l:regexp . '\>'
    endif
    return l:regexp
  else
    return ''
  endif
endfunction

function! s:HighlightCurrentWord()
  let l:word = s:GetCurrentWord()
  if !empty(l:word)
    if exists("w:current_match")
      call matchdelete(w:current_match)
    endif
    let w:current_match = matchadd('CurrentWord', l:word, 0)
  endif
endfunction

augroup cwh
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:HighlightCurrentWord()
augroup END
