SHELL=/bin/bash
DIR=$(shell pwd)
JQ_LATEST=$(shell curl -s https://api.github.com/repos/stedolan/jq/releases/latest | jq -r '.assets | .[] | select(.name | contains("linux64")) | .browser_download_url')
YQ_LATEST=$(shell curl -s https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r '.assets | .[] | select(.name | contains("linux_amd64")) | .browser_download_url' | head -1)
NVIM_LATEST=$(shell curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.assets | .[] | select(.name | contains("linux64.tar")) | .browser_download_url' | | head -1)
NODEJS_LATEST_VERSION=$(shell curl -s https://api.github.com/repos/nodejs/node/releases/latest | jq -r .tag_name)
NODEJS_LATEST=https://nodejs.org/dist/${NODEJS_LATEST_VERSION}/node-${NODEJS_LATEST_VERSION}-linux-x64.tar.xz

.PHONY: nvim

nvim: nvim-dir nvim-dependency nvim-download nvim-plugins

nvim-dir:
	@echo "Creating directories for nvim ..."
	mkdir -p ${HOME}/.local/bin ${HOME}/.local/nvim ${HOME}/.local/nodejs
	@echo "OK!"

nvim-dependency:
	@echo "Downloading jq ..."
	curl -sL ${JQ_LATEST} -o ${HOME}/.local/bin/jq && chmod +x ${HOME}/.local/bin/jq
	@echo "OK!"
	@echo "Downloading yq ..."
	curl -sL ${YQ_LATEST} -o ${HOME}/.local/bin/yq && chmod +x ${HOME}/.local/bin/yq
	@echo "OK!"
	@echo "Downloading nodejs and npm ..."
	curl -sL ${NODEJS_LATEST} | tar xJf - -C ${HOME}/.local/nodejs --strip-components=1
	@echo "OK!"
	@echo "Installing yarn and packages ..."
	${HOME}/.local/nodejs/bin/npm install -g yarn
	@echo "Copying .zshrc .bashrc .bash_funcs .bash_alias .config/nvim ..."
	for i in .zshrc .bashrc .bash_funcs .bash_alias; do ln -sfv ${DIR}/$i ${HOME}; done
	for i in .config/nvim; do ln -sfv ${DIR}/$i ${HOME}/.config; done
	@echo "OK!"
	@echo "Installing zsh ..."
	sudo apt install -y zsh 2>/dev/null || sudo yum install -y zsh 2>/dev/null
	@echo "OK!"
	@echo "Installing oh-my-zsh ..."
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	@echo "OK!"

nvim-download:
	@echo "Downloading nvim ..."
	curl -sL ${NVIM_LATEST} | tar xzf - -C ${HOME}/.local/nvim --strip-components=1
	@echo "OK!"

nvim-plugins:
	@echo "Downloading vim-plug ..."
	sh -c 'curl -fLo ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	@echo "OK!"
	@echo "Installing coc ..."
	pushd ${HOME}/.local/share/nvim/plugged/coc.nvim/
	yarn install
	popd
	@echo "OK!"
