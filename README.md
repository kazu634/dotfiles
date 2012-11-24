# ドットファイルの設定
各種設定ファイルをまとめました。

* .gitconfig
* .gitignore
* .gosh_completions
* .gvimrc
* .screenrc
* .screenrc.swp
* .vimrc
* .zshenv
* .zshrc
* install.sh

## .gitconfig
Git用の設定ファイル。

* https://gist.github.com/4117588
* http://oli.jp/2012/git-powerup/

## .vimrc
vim用の設定ファイル。

以降は使用出来るプラグインについて:

### Wordpress
次のコマンドで投稿などができます:

* BlogList [post|page]
* BlogNew [post|page]
* BlogSave [publish|draft]
* BlogPreview [local|publish|draft]
* BlogUpload *[path/to/your/local/file]
* BlogOpen *[post id or full article URL]
* BlogSwitch [0,1,2 ... N, number of account in your config]
* BlogCode [type of lang for the \<pre> element]

詳細は[ここ](https://bitbucket.org/pentie/vimrepress)を参照してください。

また、[ここ](http://vim-users.jp/2008/10/vimpress%E3%81%AE%E3%81%94%E7%B4%B9%E4%BB%8B/)も参考になる。

### Hatena
次のコマンドで投稿などができます:

* HatenaEdit

詳細は[ここ](https://github.com/motemen/hatena-vim)を参照してください。


## .gvimrc
GVim用の設定です。

### IMEの設定
[ここ](http://blogger.splhack.org/2011/01/macvim-kaoriya-20110111.html)を参照すると Mac の Kaoriya Vim ではパラメーターを指定するとノーマルモードに戻るときに自動で IME をオフにしてくれるようです。


