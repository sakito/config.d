CWD=$(shell pwd)

.PHONY: all
all:
	ln -sf ${CWD}/ghostty ${HOME}/.config/
	ln -sf ${CWD}/nvim ${HOME}/.config/

.PHONY: format
format:
	cd nvim/lua; \
	stylua ./
