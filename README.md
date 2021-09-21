![ReuseTaleBackground](https://user-images.githubusercontent.com/49183340/111032642-92f67a00-840d-11eb-8d9a-eebce4ffa9c5.jpg)

# ReuseTale
ReuseTale is a project to support the analysis of a re-use feedback in an industrial context. ReuseTale help us to import, visualize and analyse some projects datas (source-code and contributors).

Datas :
Two .csv files at the root of the project extracted from an enterprise repository of source-code.

![image](https://user-images.githubusercontent.com/49183340/134221188-75191dd5-e901-4f2d-964e-8aefaa34bba6.png)
![image](https://user-images.githubusercontent.com/49183340/134221262-3cae7d32-7892-44f4-88b9-2f61e08036c7.png)
![image](https://user-images.githubusercontent.com/49183340/134221339-c15a2304-b4a5-49ce-adb0-3ea9a4fb7801.png)


Related links :
* [15 years of reuse experience in evolutionary prototyping for the defense industry](https://doi.org/10.1007/978-3-030-64694-3_6) : The paper at the beginning of the project
* [Molecule: live prototyping with component-oriented programming](https://hal.inria.fr/hal-02966704)
* [Molecule, a component oriented framework for Pharo](https://github.com/OpenSmock/Molecule)

Related videos :
[![15 years of reuse experience in evolutionary prototyping for the defense industry](https://user-images.githubusercontent.com/49183340/134218679-4d457b61-72ab-4a37-929e-46ac2172b6ed.png)](https://www.youtube.com/embed/k9raUDp5ugA)

![Molecule: live prototyping with component-oriented programming](https://user-images.githubusercontent.com/49183340/134220291-c4f8310c-ba74-415c-892c-ce01524ed218.png)

## Loading project

For Pharo 9 :

```Smalltalk
Metacello new
  repository: 'github://OpenSmock/ReuseTale:main';
  baseline: 'ReuseTale';
  load.
```

The project works on Pharo 8 (same script to import it) without graph exportation.

## Import datas with DoIt 
These scripts imports project data files (two .csv files in project root).

```Smalltalk
"First file"
RTPrototypeDataRepository buildSubSystemsDataFromFilename: 'SubSystems_data.csv' asFileReference.
```

```Smalltalk
"Second file"
RTPrototypeDataRepository buildPrototypesDataFromFilename: 'Prototypes_data.csv' asFileReference.
```

## Import datas with UI
This is an UI to import your own files.

```Smalltalk
"First file"
RTPrototypeDataRepository openFileToBuildSubSystemsData. 
```

```Smalltalk
"Second file"
RTPrototypeDataRepository openFileToBuildPrototypesData. 
```

## Inspect imported datas

### Prototypes

```Smalltalk
RTPrototypeDataRepository prototypes inspect.
```

### SubSystems

```Smalltalk
RTPrototypeDataRepository subSystems inspect.
```

## Remove imported datas

```Smalltalk
RTPrototypeDataRepository reset.
```
A COMPLETER POUR PLUS DE CLARTE :
=> Ajouter dans l'introduction la présentation du projet : C'est un projet qui permet d'exploiter des méta-données extraitent de projets réalisés en entreprise dans un contexte industriel. L'objectif original est d'étudier la réutilisation d'éléments entre les projets sur une quinzaine d'années de développements logiciel. On utilise une partie descriptive des données, ainsi qu'une mise en forme sous la forme de visualisation 2D. Le point d'entrée consiste en deux fichiers CSV issues d'extraction automatique du code des projets étudiés. 
++ ajouter le lien vers papier IWST + liens vers les vidéos de présentation de chacun [OK]
=> Pour la mise en forme nous utilisons l'environnement de dev Pharo (+lien) et la bibliothèque Roassal3 (+ lien) pour la programmation des graphiques. + Tuto pour télécharger Pharo et installer ReuseTale
=> Ajouter la description des données présentent dans les fichiers CSV (colonnes et lignes)
=> Tuto pour afficher les graphiques avec Roassal (procédure pour executer les scripts), en prendre quelques unes et faire des copies écrans pour les expliciter
