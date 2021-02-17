"
""To load datas""
""With UI""
""#1 =>"" 
RTPrototypeDataRepository openFileToBuildSubSystemsData. 
""#2 =>"" 
RTPrototypeDataRepository openFileToBuildPrototypesData.

""Manually""
""#1 =>"" 
RTPrototypeDataRepository buildSubSystemsDataFromFilename: 
		'your\path\to\file\SubSystems_data.csv' asFileReference.
""#2 =>"" 
RTPrototypeDataRepository buildPrototypesDataFromFilename:
		'your\path\to\file\Prototypes_data.csv' asFileReference.

""To Inspect loaded datas :""
RTPrototypeDataRepository prototypes inspect.

""To clean""
RTPrototypeDataRepository clean.
"
Class {
	#name : #ManifestReuseTale,
	#superclass : #PackageManifest,
	#category : #'ReuseTale-Manifest'
}
