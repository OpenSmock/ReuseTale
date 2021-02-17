"
To load datas :

""First""
RTPrototypeDataRepository buildSubSystemsDataFromFilename: 
	'your\path\to\file\15Y-REUSE-DATA_-_SubSystems.csv' asFileReference.

""Second""
RTPrototypeDataRepository buildPrototypesDataFromFilename:
	'your\path\to\file\15Y-REUSE-DATA_-_prototypes_data.csv' asFileReference.

To Inspect loading datas :
RTPrototypeDataRepository prototypes inspect.
"
Class {
	#name : #ManifestReuseTale,
	#superclass : #PackageManifest,
	#category : #'ReuseTale-Manifest'
}
