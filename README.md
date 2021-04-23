![ReuseTaleBackground](https://user-images.githubusercontent.com/49183340/111032642-92f67a00-840d-11eb-8d9a-eebce4ffa9c5.jpg)

# ReuseTale
ReuseTale is a project to support the analysis of a re-use feedback in an industrial context. ReuseTale help us to import, visualize and analyse some projects datas (source-code and contributors).

Related links :
* [The paper at the beginning of the project](https://doi.org/10.1007/978-3-030-64694-3_6)
* [Molecule, a component oriented framework for Pharo](https://github.com/OpenSmock/Molecule)

Datas :
Two .csv files at the root of the project extracted from an enterprise repository of source-code.

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
