# Neovim Python

Un véritable IDE Python avec NeoVim et docker pour pouvoir se sentir partout comme à la maison.


## Principales fonctionnalités de la config vim

## Installation et utilisation

Commencer par mettre à jour le fichier `requirements.txt` avec les dépendances du projet sur lequel on souhaite travailler.

Puis construire l'image docker :
```
docker build -t nvim-python .
```

Ensuite pour pusher sur dockerhub, on suit la démarche habituelle:
```
docker tag nvim-python pminder/nvim-python:latest
docker push pminder/nvim-python:latest
```

Pour lancer l'image en local, on peut utiliser la commande suivante bien pratique, car elle permet de monter automatiquement le répertoire dans lequel on se trouve :
```
docker run -v `pwd`:`pwd` -w `pwd` -it --entrypoint=/bin/bash pminder/nvim-python:latest
```
