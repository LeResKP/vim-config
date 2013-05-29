all:
	if test ! -e $(HOME)/.vimrc; then ln -s $(CURDIR)/vimrc ~/.vimrc; fi
	if test ! -e $(HOME)/.vim; then ln -s $(CURDIR)/vim ~/.vim; fi
	git submodule init
	git submodule update
	git submodule foreach --recursive git submodule init
	git submodule foreach --recursive git submodule update
	sudo easy_install pyflakes flake8 pylint
