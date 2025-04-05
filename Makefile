SHELL=/bin/bash
DIR=$(shell pwd)
JQ_LINUX_AMD64_LATEST=$(shell curl -s https://api.github.com/repos/jqlang/jq/releases/latest | jq -r '.assets | .[] | select(.name | contains("linux64")) | .browser_download_url')
JQ_DARWIN_ARM64_LATEST=$(shell curl -s https://api.github.com/repos/jqlang/jq/releases/latest | jq -r '.assets | .[] | select(.name | contains("macos-arm64")) | .browser_download_url')
YQ_LINUX_AMD64_LATEST=$(shell curl -s https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r '.assets | .[] | select(.name | contains("linux_amd64")) | .browser_download_url' | head -1)
YQ_DARWIN_ARM64_LATEST=$(shell curl -s https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r '.assets | .[] | select(.name | contains("darwin_arm64")) | .browser_download_url' | head -1)
NVIM_LINUX_AMD64_LATEST=$(shell curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.assets | .[] | select(.name | contains("linux64.tar")) | .browser_download_url' | head -1)
NVIM_DARWIN_ARM64_LATEST=$(shell curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.assets | .[] | select(.name | contains("macos-arm64")) | .browser_download_url' | head -1)
NODEJS_LATEST_LTS_VERSION=$(shell curl -s https://api.github.com/repos/nodejs/node/releases | jq -r '.[] | select(.name | contains("LTS")) | .tag_name' | head -n 1)
NODEJS_LINUX_AMD64_LATEST=https://nodejs.org/dist/${NODEJS_LATEST_LTS_VERSION}/node-${NODEJS_LATEST_LTS_VERSION}-linux-x64.tar.xz
NODEJS_DARWIN_ARM64_LATEST=https://nodejs.org/dist/${NODEJS_LATEST_LTS_VERSION}/node-${NODEJS_LATEST_LTS_VERSION}-darwin-arm64.tar.xz
FZF_LINUX_AMD64_LATEST=$(shell curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | jq -r '.assets | .[] | select(.name | contains("linux_amd64")) | .browser_download_url' | head -1)
FZF_DARWIN_ARM64_LATEST=$(shell curl -s https://api.github.com/repos/junegunn/fzf/releases/latest | jq -r '.assets | .[] | select(.name | contains("darwin_arm64")) | .browser_download_url' | head -1)

.PHONY: help

help: ### Show this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?### .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?### "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

check-env:
ifndef GITHUB_TOKEN
	$(error GITHUB_TOKEN is undefined | Get it from https://github.com/settings/tokens)
endif

go-version:
ifndef GO_VERSION
	$(error GO_VERSION is undefined | Ex: GO_VERSION=1.21 | GO_VERSION=go for latest)
endif

GO_LINUX_AMD64_LATEST_VERSION=$(shell curl -sL https://golang.org/dl/ | grep -Eo 'go[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}.linux-amd64.tar.gz' | grep ${GO_VERSION} | head -n 1)
GO_DARWIN_ARM64_LATEST_VERSION=$(shell curl -sL https://golang.org/dl/ | grep -Eo 'go[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}.darwin-arm64.tar.gz' | grep ${GO_VERSION} | head -n 1)
GO_LINUX_AMD64_LATEST=https://go.dev/dl/${GO_LINUX_AMD64_LATEST_VERSION}
GO_DARWIN_ARM64_LATEST=https://go.dev/dl/${GO_DARWIN_ARM64_LATEST_VERSION}

.PHONY: nvim-darwin-arm64

nvim-darwin-arm64: nvim-darwin-arm64-dir dotfiles-nvim-darwin-arm64-download nvim-darwin-arm64-dependency nvim-darwin-arm64-download nvim-darwin-arm64-plugins ### Install nvim on Mac ARM64

nvim-darwin-arm64-dir:
	@echo "Creating directories for nvim ..."
	mkdir -p ${HOME}/.local/bin ${HOME}/.local/nvim ${HOME}/.local/nodejs ${HOME}/.local/share/nvim/site/pack/coc/start ${HOME}/.zsh_history ${HOME}/.config/nvim
	@echo "OK!"

dotfiles-nvim-darwin-arm64-download:
	@echo "Copying .config/nvim ..."
	cp -av .config/nvim/* ${HOME}/.config/nvim
	@echo "OK!"

nvim-darwin-arm64-dependency: jq-darwin-arm64-download yq-darwin-arm64-download nodejs-darwin-arm64-download yarn-darwin-arm64-download

jq-darwin-arm64-download:
	@echo "Downloading jq ..."
	curl -H "Authorization: ${GITHUB_TOKEN}" -sL ${JQ_DARWIN_ARM64_LATEST} -o ${HOME}/.local/bin/jq && chmod +x ${HOME}/.local/bin/jq
	@echo "OK!"

yq-darwin-arm64-download:
	@echo "Downloading yq ..."
	curl -sL ${YQ_DARWIN_ARM64_LATEST} -o ${HOME}/.local/bin/yq && chmod +x ${HOME}/.local/bin/yq
	@echo "OK!"

nodejs-darwin-arm64-download:
	@echo "Downloading nodejs and npm ..."
	curl -sL ${NODEJS_DARWIN_ARM64_LATEST} | tar xJf - -C ${HOME}/.local/nodejs --strip-components=1
	@echo "OK!"

yarn-darwin-arm64-download:
	@echo "Installing yarn and packages ..."
	export PATH=${PATH}:${HOME}/.local/nodejs/bin && ${HOME}/.local/nodejs/bin/npm install -g yarn

nvim-darwin-arm64-download:
	@echo "Downloading nvim ..."
	curl -sL ${NVIM_DARWIN_ARM64_LATEST} | tar xzf - -C ${HOME}/.local/nvim --strip-components=1
	@echo "OK!"

nvim-darwin-arm64-plugins:
	@echo "Downloading vim-plug ..."
	curl -sfLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@echo "OK!"
	@echo "Installing coc ..."
	cd ${HOME}/.local/share/nvim/site/pack/coc/start && curl -sfL https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzf -
	@echo "OK!"

.PHONY: nvim-linux-amd64

nvim-linux-amd64: nvim-linux-amd64-dir dotfiles-nvim-linux-amd64-download nvim-linux-amd64-dependency nvim-linux-amd64-download nvim-linux-amd64-plugins ### Install nvim on Linux x86

nvim-linux-amd64-dir:
	@echo "Creating directories for nvim ..."
	mkdir -p ${HOME}/.local/bin ${HOME}/.local/nvim ${HOME}/.local/nodejs ${HOME}/.local/share/nvim/site/pack/coc/start ${HOME}/.zsh_history ${HOME}/.config/nvim
	@echo "OK!"

dotfiles-nvim-linux-amd64-download:
	@echo "Copying .config/nvim ..."
	cp -av .config/nvim/* ${HOME}/.config/nvim
	@echo "OK!"

nvim-linux-amd64-dependency: jq-linux-amd64-download yq-linux-amd64-download nodejs-linux-amd64-download yarn-linux-amd64-download

jq-linux-amd64-download:
	@echo "Downloading jq ..."
	curl -H "Authorization: ${GITHUB_TOKEN}" -sL ${JQ_LINUX_AMD64_LATEST} -o ${HOME}/.local/bin/jq && chmod +x ${HOME}/.local/bin/jq
	@echo "OK!"

yq-linux-amd64-download:
	@echo "Downloading yq ..."
	curl -sL ${YQ_LINUX_AMD64_LATEST} -o ${HOME}/.local/bin/yq && chmod +x ${HOME}/.local/bin/yq
	@echo "OK!"

nodejs-linux-amd64-download:
	@echo "Downloading nodejs and npm ..."
	curl -sL ${NODEJS_LINUX_AMD64_LATEST} | tar xJf - -C ${HOME}/.local/nodejs --strip-components=1
	@echo "OK!"

yarn-linux-amd64-download:
	@echo "Installing yarn and packages ..."
	export PATH=${PATH}:${HOME}/.local/nodejs/bin && ${HOME}/.local/nodejs/bin/npm install -g yarn

nvim-linux-amd64-download:
	@echo "Downloading nvim ..."
	curl -sL ${NVIM_LINUX_AMD64_LATEST} | tar xzf - -C ${HOME}/.local/nvim --strip-components=1
	@echo "OK!"

nvim-linux-amd64-plugins:
	@echo "Downloading vim-plug ..."
	curl -sfLo ${HOME}/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@echo "OK!"
	@echo "Installing coc ..."
	cd ${HOME}/.local/share/nvim/site/pack/coc/start && curl -sfL https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzf -
	@echo "OK!"

.PHONY: go-linux-amd64

go-linux-amd64: go-version go-linux-amd64-dir go-linux-amd64-download ### Install Go on Linux x86

go-linux-amd64-find-version: go-version ### Find Golang version for x86_64
	@echo "Finding version ..."
	curl -sL https://golang.org/dl/ | grep -Eo 'go[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}.linux-amd64.tar.gz' | grep ${GO_VERSION} | head

go-linux-amd64-dir:
	@echo "Creating directories for go ..."
	mkdir -p ${HOME}/.local/go
	@echo "OK!"

go-linux-amd64-download:
	@echo "Downloading go ..."
	curl -sfL ${GO_LINUX_AMD64_LATEST} | tar xzf - -C ${HOME}/.local
	@echo "OK!"

.PHONY: go-darwin-arm64

go-darwin-arm64: go-version go-darwin-arm64-dir go-darwin-arm64-download ### Install Go on Mac ARM64

go-darwin-arm64-find-version: go-version ### Find Golang version for ARM64
	@echo "Finding version ..."
	curl -sL https://golang.org/dl/ | grep -Eo 'go[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}.darwin-arm64.tar.gz' | grep ${GO_VERSION} | head

go-darwin-arm64-dir:
	@echo "Creating directories for go ..."
	mkdir -p ${HOME}/.local/go
	@echo "OK!"

go-darwin-arm64-download:
	@echo "Downloading go ..."
	curl -sfL ${GO_DARWIN_ARM64_LATEST} | tar xzf - -C ${HOME}/.local
	@echo "OK!"

.PHONY: ohmyzsh

ohmyzsh: ohmyzsh-download ohmyzsh-theme dotfiles-ohmyzsh-download ### Install and configure Oh My Zsh!

ohmyzsh-download:
	@echo "Installing oh-my-zsh ..."
	rm -rf ~/.oh-my-zsh && git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
	git clone https://github.com/zsh-users/zsh-autosuggestions.git ${HOME}/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
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

git: git-config ### Configure Git

git-config:
	@echo "Copying .gitconfig ..."
	cp -av .gitconfig ${HOME}
	@echo "OK!"

.PHONY: kind-linux-amd64-download

kind-linux-amd64-download: ### Install Kind on Linux x86
	@echo "Downloading kind ..."
	@sudo curl -sLo /usr/local/bin/kind $$(curl -sL https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | jq -r '.assets | .[] | select(.name == "kind-linux-amd64") | .browser_download_url')
	@sudo chmod +x /usr/local/bin/kind
	@echo "OK"
	@echo "Downloading kubectl ..."
	@sudo curl -sLo /usr/local/bin/kubectl https://dl.k8s.io/release/$$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
	@sudo chmod +x /usr/local/bin/kubectl
	@echo "OK"

.PHONY: kind-darwin-arm64-download

kind-darwin-arm64-download: ### Install Kind on Mac ARM64
	@echo "Downloading kind ..."
	@sudo curl -sLo /usr/local/bin/kind $$(curl -sL https://api.github.com/repos/kubernetes-sigs/kind/releases/latest | jq -r '.assets | .[] | select(.name == "kind-darwin-amd64") | .browser_download_url')
	@sudo chmod +x /usr/local/bin/kind
	@echo "OK"
	@echo "Downloading kubectl ..."
	@sudo curl -sLo /usr/local/bin/kubectl https://dl.k8s.io/release/$$(curl -sL https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl
	@sudo chmod +x /usr/local/bin/kubectl
	@echo "OK"

.PHONY: kind-create

kind-create-onp: ### Create a Kind cluster
	@echo "Creating kind cluster ..."
	@sudo KIND_EXPERIMENTAL_PROVIDER=podman kind create cluster --name onp
	@sudo cp /root/.kube/config ${HOME}/.kube/kind-config
	@sudo chown onp:onp ${HOME}/.kube/kind-config
	@echo "OK"
	@echo "Try, export KUBECONFIG=${HOME}/.kube/kind-config && kubectl get nodes."

.PHONY: kind-delete

kind-delete-onp: ### Delete the Kind cluster
	@echo "Deleting kind cluster ..."
	@sudo KIND_EXPERIMENTAL_PROVIDER=podman kind delete cluster --name onp
	@rm -rf ${HOME}/.kube/kind-config

.PHONY: fzf-linux-amd64

fzf-linux-amd64: ### Install fzf on Linux x86
	@echo "Cloning fzf ..."
	@rm -rf ${HOME}/.fzf && git clone https://github.com/junegunn/fzf.git ${HOME}/.fzf
	@echo "Downloading fzf ..."
	@curl -sL ${FZF_LINUX_AMD64_LATEST} | tar xzf - -C ${HOME}/.local/bin fzf
	@echo "Patching ${HOME}/.fzf/shell/key-bindings.zsh ..."
	@sed -i 's/\\ec/\^F/g' ${HOME}/.fzf/shell/key-bindings.zsh

.PHONY: fzf-darwin-arm64

fzf-darwin-arm64: ### Install fzf on Mac ARM64
	@echo "Cloning fzf ..."
	@rm -rf ${HOME}/.fzf && git clone https://github.com/junegunn/fzf.git ${HOME}/.fzf
	@echo "Downloading fzf ..."
	@curl -sL ${FZF_DARWIN_ARM64_LATEST} | tar xzf - -C ${HOME}/.local/bin fzf
	@chmod +x ~/.local/bin/fzf
	@echo "Patching ${HOME}/.fzf/shell/key-bindings.zsh ..."
	@sed -i '' 's/\\ec/\^F/g' ${HOME}/.fzf/shell/key-bindings.zsh

.PHONY: gnupg

gnupg: ### Configure GnuPG
	@echo "Configuring GNUPG ..."
	mkdir -p ${HOME}/.gnupg && cp -av ./.gnupg/gpg-agent.conf ${HOME}/.gnupg/
	@echo "OK!"
	@echo "Configuring GNUPG SSH ..."
	gpg --list-keys --with-keygrip | awk '/\[A\]/{getline; print $$3}' >> ${HOME}/.gnupg/sshcontrol
	@echo "OK!"
