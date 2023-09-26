SHELL=/bin/bash
DIR=$(shell pwd)
JQ_LATEST=$(shell curl -s https://api.github.com/repos/jqlang/jq/releases/latest | jq -r '.assets | .[] | select(.name | contains("linux64")) | .browser_download_url')
YQ_LATEST=$(shell curl -s https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r '.assets | .[] | select(.name | contains("linux_amd64")) | .browser_download_url' | head -1)
NVIM_LATEST=$(shell curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.assets | .[] | select(.name | contains("linux64.tar")) | .browser_download_url' | head -1)
NODEJS_LATEST_VERSION=$(shell curl -s https://api.github.com/repos/nodejs/node/releases | jq -r '.[] | select(.name | contains("LTS")) | .tag_name' | head -n 1)
NODEJS_LATEST=https://nodejs.org/dist/${NODEJS_LATEST_VERSION}/node-${NODEJS_LATEST_VERSION}-linux-x64.tar.xz
FZF_LATEST=$(shell curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | jq -r '.assets | .[] | select(.name | contains("linux_amd64")) | .browser_download_url' | head -1)

check-env:
ifndef GITHUB_TOKEN
	$(error GITHUB_TOKEN is undefined | Get it from https://github.com/settings/tokens)
endif

go-version:
ifndef GO_VERSION
	$(error GO_VERSION is undefined | Example: 1.8.0)
endif

GO_LATEST_VERSION=$(shell curl -sL https://golang.org/dl/ | grep -Eo 'go[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}.linux-amd64.tar.gz' | grep go | head -n 1)
GO_LATEST=https://go.dev/dl/${GO_LATEST_VERSION}

.PHONY: nvim

nvim: nvim-dir dotfiles-nvim-download nvim-dependency nvim-download nvim-plugins

nvim-dir:
	@echo "Creating directories for nvim ..."
	mkdir -p ${HOME}/.local/bin ${HOME}/.local/nvim ${HOME}/.local/nodejs ${HOME}/.local/share/nvim/site/pack/coc/start ${HOME}/.zsh_history ${HOME}/.config/nvim
	@echo "OK!"

dotfiles-nvim-download:
	@echo "Copying .config/nvim ..."
	cp -av .config/nvim/* ${HOME}/.config/nvim
	@echo "OK!"

nvim-dependency: jq-download yq-download nodejs-download yarn-download

jq-download:
	@echo "Downloading jq ..."
	curl -H "Authorization: ${GITHUB_TOKEN}" -sL ${JQ_LATEST} -o ${HOME}/.local/bin/jq && chmod +x ${HOME}/.local/bin/jq
	@echo "OK!"

yq-download:
	@echo "Downloading yq ..."
	curl -sL ${YQ_LATEST} -o ${HOME}/.local/bin/yq && chmod +x ${HOME}/.local/bin/yq
	@echo "OK!"

nodejs-download:
	@echo "Downloading nodejs and npm ..."
	curl -sL ${NODEJS_LATEST} | tar xJf - -C ${HOME}/.local/nodejs --strip-components=1
	@echo "OK!"

yarn-download:
	@echo "Installing yarn and packages ..."
	export PATH=${PATH}:${HOME}/.local/nodejs/bin && ${HOME}/.local/nodejs/bin/npm install -g yarn

nvim-download:
	@echo "Downloading nvim ..."
	curl -sL ${NVIM_LATEST} | tar xzf - -C ${HOME}/.local/nvim --strip-components=1
	@echo "OK!"

nvim-plugins:
	@echo "Downloading vim-plug ..."
	curl -sfLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@echo "OK!"
	@echo "Installing coc ..."
	cd ${HOME}/.local/share/nvim/site/pack/coc/start && curl -sfL https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzf -
	@echo "OK!"

.PHONY: go

go: go-version go-dir go-download

go-find-version: go-version
	@echo "Finding version ..."
	curl -sL https://golang.org/dl/ | grep -Eo 'go[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}.linux-amd64.tar.gz' | grep ${GO_VERSION}

go-dir:
	@echo "Creating directories for go ..."
	mkdir -p ${HOME}/.local/go
	@echo "OK!"

go-download:
	@echo "Downloading go ..."
	curl -sfL ${GO_LATEST} | tar xzf - -C ${HOME}/.local
	@echo "OK!"

.PHONY: ohmyzsh

ohmyzsh: ohmyzsh-download ohmyzsh-theme dotfiles-ohmyzsh-download

ohmyzsh-download:
	@echo "Installing oh-my-zsh ..."
	rm -rf ~/.oh-my-zsh && git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	@echo "OK!"

ohmyzsh-theme:
	@echo "Modifying oh-my-zsh theme ..."
	cp -av .oh-my-zsh/custom/themes/robbyrussell.zsh-theme ${HOME}/.oh-my-zsh/custom/themes/robbyrussell.zsh-theme
	@echo "OK!"

dotfiles-ohmyzsh-download:
	@echo "Copying .zshrc ..."
	cp -av .zshrc ${HOME}
	cp -av .bash_profile ${HOME}
	rm -rf ${HOME}/.zshrc.d && mkdir -p ${HOME}/.zshrc.d
	cp -av .bash_alias ${HOME}/.zshrc.d
	cp -av .bash_funcs ${HOME}/.zshrc.d
	@echo "OK!"

.PHONY: git

git: git-config

git-config:
	@echo "Copying .gitconfig ..."
	cp -av .gitconfig ${HOME}
	@echo "OK!"

.PHONY: kind-download

kind-download:
	@echo "Downloading kind ..."
	@sudo curl -sLo /usr/local/bin/kind $$(curl -sL https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | jq -r '.assets | .[] | select(.name == "kind-linux-amd64") | .browser_download_url')
	@sudo chmod +x /usr/local/bin/kind
	@echo "OK"
	@echo "Downloading kubectl ..."
	@sudo curl -sLo /usr/local/bin/kubectl https://dl.k8s.io/release/$$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
	@sudo chmod +x /usr/local/bin/kubectl
	@echo "OK"

.PHONY: kind-create

kind-create-onp:
	@echo "Creating kind cluster ..."
	@sudo KIND_EXPERIMENTAL_PROVIDER=podman kind create cluster --name onp
	@sudo cp /root/.kube/config ${HOME}/.kube/kind-config
	@sudo chown onp:onp ${HOME}/.kube/kind-config
	@echo "OK"
	@echo "Try, export KUBECONFIG=${HOME}/.kube/kind-config && kubectl get nodes."

.PHONY: kind-delete

kind-delete-onp:
	@echo "Deleting kind cluster ..."
	@sudo KIND_EXPERIMENTAL_PROVIDER=podman kind delete cluster --name onp
	@rm -rf ${HOME}/.kube/kind-config

.PHONY: fzf

fzf:
	@echo "Cloning fzf ..."
	@rm -rf ${HOME}/.fzf && git clone https://github.com/junegunn/fzf.git ${HOME}/.fzf
	@echo "Downloading fzf ..."
	@curl -sL ${FZF_LATEST} | tar xz fzf -C ${HOME}/.local/bin/fzf
	@echo "Patching ${HOME}/.fzf/shell/key-bindings.zsh ..."
	@sed -i 's/\\ec/\^F/g' ${HOME}/.fzf/shell/key-bindings.zsh
