FROM archlinux/base

RUN pacman --noconfirm -Syu
RUN pacman --noconfirm -S python neovim python-pip git ctags

# Installer les dépendances python pour les plugins nvim
RUN mkdir /requirements
COPY requirements.txt /requirements/
RUN pip install pynvim jedi pep8 flake8 pyflakes isort yapf
# Installer les dépendances du projet
RUN pip install -r /requirements/requirements.txt

# Configurer les plugins nvim
RUN mkdir -p /work/.config/nvim/
COPY init.vim /work/.config/nvim/init.vim
RUN curl -fLo /work/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Créer une home partagée par tous les utilisateurs
# TODO : variabiliser le home
RUN echo "export HOME=/work" >> /etc/bash.bashrc
ENV HOME=/work
# Modifier le prompt pour éviter "I have no name"
RUN echo "PS1=\"dev:\w\$ \"" >> /etc/bash.bashrc
# Lancer nvim pour ne pas avoir à réinstaller les plugins à chaque run
RUN nvim +'PlugInstall --sync' +'PlugUpdate' +qa

# Donner tous les droits à tout le monde sur le home
RUN chmod -R 777 /work
WORKDIR /work

# Pour pouvoir lancer un pod sur OpenPaas et s'y connecter ensuite
CMD  while :; do echo 'running...'; sleep 1; done

