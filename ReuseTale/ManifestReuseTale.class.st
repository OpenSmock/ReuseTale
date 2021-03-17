"
## Import datas with DoIt 
These scripts imports project data files (two .csv files in project root).

""First file""
RTPrototypeDataRepository reset.
RTPrototypeDataRepository buildSubSystemsDataFromFilename: 'SubSystems_data.csv' asFileReference.

""Second file""
RTPrototypeDataRepository buildPrototypesDataFromFilename: 'Prototypes_data.csv' asFileReference.

## Import datas with UI
This is an UI to import your own files.

""First file""
RTPrototypeDataRepository reset.
RTPrototypeDataRepository openFileToBuildSubSystemsData. 

""Second file""
RTPrototypeDataRepository openFileToBuildPrototypesData. 

## Inspect imported datas

### Prototypes

RTPrototypeDataRepository prototypes inspect.

### SubSystems

RTPrototypeDataRepository subSystems inspect.

## Remove imported datas

RTPrototypeDataRepository reset.

"
Class {
	#name : #ManifestReuseTale,
	#superclass : #PackageManifest,
	#category : #'ReuseTale-Manifest'
}
