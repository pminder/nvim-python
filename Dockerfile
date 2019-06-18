FROM archlinux/base

RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S python neovim python-pip git ctags

RUN mkdir /requirements
COPY requirements.txt /requirements/
# Installer les dépendances du projet
RUN pip install pynvim jedi pep8 flake8 pyflakes isort yapf
RUN pip install -r /requirements/requirements.txt

RUN useradd -m pminder
RUN mkdir -p /home/pminder/.config/nvim/
COPY init.vim /home/pminder/.config/nvim/init.vim
RUN chown -R pminder /home/pminder

USER pminder
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN nvim +'PlugInstall --sync' +'PlugUpdate' +qa 

CMD  while :; do echo 'running...'; sleep 1; done

