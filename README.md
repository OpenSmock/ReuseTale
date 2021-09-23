![ReuseTaleBackground](https://user-images.githubusercontent.com/49183340/111032642-92f67a00-840d-11eb-8d9a-eebce4ffa9c5.jpg)

# ReuseTale
ReuseTale is a project to support the analysis of a re-use feedback in an industrial context. ReuseTale help us to import, visualize and analyse some projects datas (source-code and contributors). It is a project that makes it possible to exploit metadata extracted from projects carried out in companies in an industrial context. The original objective is to study the reuse of elements between projects over fifteen years of software development. A descriptive part of the data is used, as well as a formatting in the form of 2D visualization. The entry point consists of two CSV files resulting from automatic extraction of the code of the studied projects. 

Datas are into two .csv files at the root of the project extracted from an enterprise repository of source-code.

![image](https://user-images.githubusercontent.com/49183340/134222961-82f9d52f-3675-43a1-95fe-868cf55ec77c.png)

=> Ajouter la description des données présentent dans les fichiers CSV (colonnes et lignes)

For formatting we use the [Pharo](https://pharo.org/) development environment and for programming graphics the [Roassal3](https://github.com/ObjectProfile/Roassal3) library. 

<img src="https://user-images.githubusercontent.com/49183340/134221188-75191dd5-e901-4f2d-964e-8aefaa34bba6.png" width= "30%" height="33%" align="left">
<img src="https://user-images.githubusercontent.com/49183340/134221262-3cae7d32-7892-44f4-88b9-2f61e08036c7.png" width= "30%" height="33%" align="left">
<img src="https://user-images.githubusercontent.com/49183340/134221339-c15a2304-b4a5-49ce-adb0-3ea9a4fb7801.png" width= "30%" height="33%">
  
## How to install and use the project

This section detail how to install the project from scratch.

### Get Pharo 9 (also available for Pharo 8)

Download and install the [Pharo Launcher](https://pharo.org/download.html) for your operating system (Windows, GNU/Linux or MacOs).
The Pharo launcher help to download and install some Pharo images, some documentation here to [install a Pharo 9 image with the Pharo Launcher](https://pharo-project.github.io/pharo-launcher/create-images/).

When the pharo 9 image is created, start it and execute the loading project code below.

### Loading project into Pharo

For Pharo 9, open a Playground and execute this code :

```Smalltalk
Metacello new
  repository: 'github://OpenSmock/ReuseTale:main';
  baseline: 'ReuseTale';
  load.
```

![LoadProject](https://user-images.githubusercontent.com/49183340/134548348-fdfc7bbc-6101-4de4-945e-dc60f3d27ae4.gif)

The project works on Pharo 8 (same script to import it) without graph exportation.

### Import datas from files

#### Method A : Import datas with our Wizard
This is an UI to import your own files.

```Smalltalk
"First file"
RTPrototypeDataRepository openFileToBuildSubSystemsData. 
```

```Smalltalk
"Second file"
RTPrototypeDataRepository openFileToBuildPrototypesData. 
```

#### Method B : Import datas manualy ("DoIt" method) 
These scripts imports project data files (two .csv files in project root).

Open a Playground and execute this code :

```Smalltalk
"First file"
RTPrototypeDataRepository buildSubSystemsDataFromFilename: 'SubSystems_data.csv' asFileReference.
```

Open a Playground and execute this code :

```Smalltalk
"Second file"
RTPrototypeDataRepository buildPrototypesDataFromFilename: 'Prototypes_data.csv' asFileReference.
```

### How to consult some stat view

Browse the Pharo classes packages to our projet : "ReuseTale" and go to the "RTGraphs" class. In class side select the script yout want to run and display the stat view in a window. Each opened stat view is automaticaly exported into a PDF file at the root of the pharo image. 

![GraphView](https://user-images.githubusercontent.com/49183340/134546243-1755e555-9cbe-4b6c-ab40-b29bb0a65d5f.gif)

### Navigate on imported datas

#### Prototypes datas

```Smalltalk
RTPrototypeDataRepository prototypes inspect.
```

![InspectPrototypes](https://user-images.githubusercontent.com/49183340/134537802-229d15ed-2d27-49d2-8fce-4f8ebd571995.gif)

#### SubSystems datas

```Smalltalk
RTPrototypeDataRepository subSystems inspect.
```

![InspectSubsystems](https://user-images.githubusercontent.com/49183340/134542327-ee323f8e-d7dc-481a-89e7-cab4aa2a8e78.gif)

### Remove imported datas

```Smalltalk
RTPrototypeDataRepository reset.
```

## To know more...

Some related links :
* [15 years of reuse experience in evolutionary prototyping for the defense industry](https://doi.org/10.1007/978-3-030-64694-3_6) : The paper at the beginning of the project
* [Molecule: live prototyping with component-oriented programming](https://hal.inria.fr/hal-02966704)
* [Molecule, a component oriented framework for Pharo](https://github.com/OpenSmock/Molecule)

Some related videos :
[![15 years of reuse experience in evolutionary prototyping for the defense industry](https://user-images.githubusercontent.com/49183340/134218679-4d457b61-72ab-4a37-929e-46ac2172b6ed.png)](https://www.youtube.com/embed/k9raUDp5ugA)
![Molecule: live prototyping with component-oriented programming](https://user-images.githubusercontent.com/49183340/134220291-c4f8310c-ba74-415c-892c-ce01524ed218.png)

## Credits

* **Pierre Laborde** - *Initial work* - [labordep](https://github.com/labordep)
* **Steven Costiou** - *Initial work* - [StevenCostiou](https://github.com/StevenCostiou)
* **Eric Le Pors** - *Initial work* - [ELePors](https://github.com/ELePors)
* **Alain Plantec** - *Initial work* - [plantec](https://github.com/plantec)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
