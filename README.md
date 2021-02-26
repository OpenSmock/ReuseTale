# ReuseTale

## Loading project

```Smalltalk
Metacello new
  repository: 'github://OpenSmock/ReuseTale:main';
  baseline: 'ReuseTale';
  load.
```

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
