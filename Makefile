SHELL=/bin/bash
DIR=$(shell pwd)


.PHONY: install-nvim

install-nvim:
	@echo "Creating directories ..."
	mkdir -p ${HOME}/.local/bin
	@echo "Downloading jq ..."
	(curl -sL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o ${HOME}/.local/bin/jq && chmod +x ${HOME}/.local/bin/jq) && echo "Installed jq"
	@echo "Downloading yq ..."
	(curl -sL https://github.com/mikefarah/yq/releases/download/v4.24.5/yq_linux_amd64 -o ${HOME}/.local/bin/yq && chmod +x ${HOME}/.local/bin/yq) && echo "Installed yq"
	@echo "Downloading nvim ..."
	(mkdir -p ${HOME}/.local/nvim && curl -sL https://github.com/neovim/neovim/releases/download/v0.7.0/nvim-linux64.tar.gz | tar xzf - -C ${HOME}/.local/nvim --strip-components=1) && echo "Installed nvim"
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	for i in .zshrc .bashrc .bash_funcs .bash_alias; do ln -sfv ${DIR}/$i ${HOME}; done
	for i in .config/nvim; do ln -sfv ${DIR}/$i ${HOME}/.config; done
	(mkdir -p ${HOME}/.local/nodejs && curl -sL https://nodejs.org/dist/v16.14.2/node-v16.14.2-linux-x64.tar.xz | tar xJf - -C ${HOME}/.local/nodejs --strip-components=1) && echo "Installed nodejq"
	${HOME}/.local/nodejs/bin/npm install -g yarn
	pushd ${HOME}/.local/share/nvim/plugged/coc.nvim/
	yarn install
	popd
	apt install -y zsh || yum install -y zsh
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
