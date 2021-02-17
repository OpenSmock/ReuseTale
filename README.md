# ReuseTale

## Loading project

```Smalltalk
Metacello new
  repository: 'github://OpenSmock/ReuseTale:main';
  baseline: 'ReuseTale';
  load.
```

## Import datas with UI

```Smalltalk
"First file"
RTPrototypeDataRepository openFileToBuildSubSystemsData. 
```

```Smalltalk
"Second file"
RTPrototypeDataRepository openFileToBuildPrototypesData. 
```


## Import datas with DoIt 

```Smalltalk
"First file"
RTPrototypeDataRepository buildSubSystemsDataFromFilename: 'your\path\SubSystems_data.csv' asFileReference.
```

```Smalltalk
"Second file"
RTPrototypeDataRepository buildPrototypesDataFromFilename: 'your\path\Prototypes_data.csv' asFileReference.
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
