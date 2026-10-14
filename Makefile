install:
	mkdir -p ~/.vim/bundle
	ln -sf ~/.vim/vimrc ~/.vimrc
	vim +PluginInstall +qall
