# CityMobis - Implementation de la Gestion des Demandes Citoyennes

Bienvenue sur CityMobis, une application dédiée à la gestion des demandes citoyennes dans notre ville. Cette application permet de classer les demandes des utilisateurs en trois catégories principales : signalement urbain, signalement sur la chaussée et proposition d'idée. De plus, elle attribue automatiquement un niveau d'importance à chaque demande, facilitant ainsi la priorisation pour les autorités municipales.

## Fonctionnalités Principales

### 1. Classification des Demandes

CityMobis propose trois catégories de demandes pour mieux organiser les informations :

- **Signalement Urbain :** Pour les problèmes liés à l'environnement urbain tels que les déchets, l'éclairage public, etc.

- **Signalement sur la Chaussée :** Pour les problèmes liés à la voirie, tels que les nids-de-poule, les travaux en cours, etc.

- **Proposition d'Idée :** Permet aux citoyens de soumettre des idées et suggestions pour améliorer la ville.

### 2. Classification par Niveau d'Importance

Chaque demande est automatiquement évaluée en fonction de son niveau d'importance. Ceci aide la municipalité à prioriser les actions nécessaires en fonction de l'urgence et de l'impact sur la communauté.

- **Niveau d'Importance Peu urgent :** Demandes non urgentes ou nécessitant une action à long terme.

- **Niveau d'Importance Urgent :** Demandes nécessitant une action dans un délai raisonnable.

- **Niveau d'Importance Très urgent :** Demandes urgentes nécessitant une intervention immédiate.

## Comment Utiliser le système de demande dans CityMobis

1. **Soumission des Demandes :** Soumettez votre demande en détaillant le problème ou la suggestion.

2. **Suivi des Demandes :** La municipalité peut suivre le statut des demandes des citoyens

3. **Classement par type et priorisation Automatique :** CityMobis attribuera automatiquement un niveau d'importance et classera par type à chaque demande pour faciliter la gestion par la municipalité.


## Prérequis
1. Flutter
2. Android Studio
3. Visual Studio Code

Les deux (1 et 2) peuvent être installés en suivant le guide d'installation de Flutter suivant: https://docs.flutter.dev/get-started/install
Le guide explique également comment installer l'émulateur Android ou utiliser votre téléphone pour lancer l'application.

Vous pouvez à tout moment vérifier si votre installation Flutter est complète en lançant la commande
```shell
flutter doctor -v
```
À noter qu'il n'est pas nécessaire de faire la configuration pour pouvoir développer des application Flutter pour le web (Chrome) et Windows.

## Configuration du projet
### Clone du projet
Le projet est à cloner avec la commande suivante:
```shell
git clone https://github.com/Benjamintxt/ProjetTechnologieEmergente.git
```
### Installation des dépendances
Une fois le projet cloné, on peut ouvrir le projet dans Android Studio ou dans un terminal et installer les dépendances avec la commande 
```shell
flutter pub get
```

### Lançement de l'application
Le lancement de l'application se fait via Visual Studio Code où vous pouvez choisir votre émulateur ou débogage USB d'un appareil physique (en bas à droite d'Visual Studio Code).
Effectuez la ligne de commande suivante lorsque que vous êtes dans le dossier "technoemergentes":

```shell
flutter run
```

## Équipe de développement du projet d'implementation des demandes citoyennes

Benjamin Casey & Lambert Kasaev

Merci d'utiliser CityMobis pour contribuer à rendre notre ville meilleure !
