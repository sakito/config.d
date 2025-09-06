CWD=$(shell pwd)

.PHONY: all
all:
	ln -sf ${CWD}/fd ${HOME}/.config/
	ln -sf ${CWD}/ghostty ${HOME}/.config/
	ln -sf ${CWD}/git ${HOME}/.config/
	ln -sf ${CWD}/lazygit ${HOME}/.config/
	ln -sf ${CWD}/nvim ${HOME}/.config/
	ln -sf ${CWD}/ruff ${HOME}/.config/
	ln -sf ${CWD}/tmux ${HOME}/.config/
	ln -sf ${CWD}/yazi ${HOME}/.config/

.PHONY: format
format:
	cd nvim/lua; \
	stylua ./
