# ReuseTale

## Loading project

```Smalltalk
Metacello new
  repository: 'github://OpenSmock/ReuseTale:main';
  baseline: 'ReuseTale';
  load.
```

## Import datas

```Smalltalk
"First file"
RTPrototypeDataRepository openFileToBuildSubSystemsData. 
```

```Smalltalk
"Second file"
RTPrototypeDataRepository openFileToBuildPrototypesData. 
```

```Smalltalk
"To check results"
RTPrototypeDataRepository prototypes inspect.
RTPrototypeDataRepository subSystems inspect.
```

```Smalltalk
"To clean results"
RTPrototypeDataRepository clean.
```
