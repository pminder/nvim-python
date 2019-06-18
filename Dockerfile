FROM archlinux/base

RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S python neovim python-pip git ctags
RUN pip install pynvim jedi pep8 flake8 pyflakes isort yapf
RUN curl -fLo /root/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Installer les dépendances du projet
RUN mkdir /requirements
COPY requirements.txt /requirements
RUN pip install -r /requirements/requirements.txt

RUN mkdir -p /root/.config/nvim/
COPY init.vim /root/.config/nvim/init.vim
RUN nvim +'PlugInstall --sync' +'PlugUpdate' +qa 

CMD echo "hello world"
