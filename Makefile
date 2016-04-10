install:
	git submodule init
	git submodule update
	mkdir -p ~/.vim/bundle
	ln -sf ~/.vim/vimrc ~/.vimrc
	vim +PluginInstall +qall
