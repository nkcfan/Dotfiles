#!/bin/bash -ex

# coc.nvim dependencies
python2 -m pip install pynvim jedi
python3 -m pip install pynvim jedi
python3 -m pip install yapf isort flake8
pip3 install ruff
npm install -g neovim
npm install -g prettier

# cabal
cabal update
cabal install alex

# pip
pip2 install pip-review
python2 -m pip_review --interactive
pip3 install pip-review
python3 -m pip_review --interactive

# go
go get -u all
