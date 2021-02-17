Class {
	#name : #RTData,
	#superclass : #Object,
	#instVars : [
		'name',
		'sourceCodeData',
		'publications',
		'nbDevelopers',
		'mostRecentVersionDate',
		'firstVersionDate',
		'description'
	],
	#category : #'ReuseTale-model'
}

{ #category : #accessing }
RTData >> description [

	^ description
]

{ #category : #accessing }
RTData >> description: anObject [

	description := anObject
]

{ #category : #accessing }
RTData >> firstVersionDate [

	^ firstVersionDate
]

{ #category : #accessing }
RTData >> firstVersionDate: anObject [

	firstVersionDate := anObject
]

{ #category : #accessing }
RTData >> mostRecentVersionDate [

	^ mostRecentVersionDate
]

{ #category : #accessing }
RTData >> mostRecentVersionDate: anObject [

	mostRecentVersionDate := anObject
]

{ #category : #accessing }
RTData >> name [

	^ name
]

{ #category : #accessing }
RTData >> name: anObject [

	name := anObject
]

{ #category : #statistics }
RTData >> nbClasses [

	^self sourceCodeData classes
]

{ #category : #statistics }
RTData >> nbComponents [

	^self sourceCodeData components
]

{ #category : #accessing }
RTData >> nbDevelopers [

	^ nbDevelopers
]

{ #category : #accessing }
RTData >> nbDevelopers: anObject [

	nbDevelopers := anObject
]

{ #category : #statistics }
RTData >> nbMethods [

	^self sourceCodeData methods
]

{ #category : #accessing }
RTData >> publications [

	^ publications
]

{ #category : #accessing }
RTData >> publications: anObject [

	publications := anObject
]

{ #category : #accessing }
RTData >> sourceCodeData [
	^ sourceCodeData
]

{ #category : #accessing }
RTData >> sourceCodeData: anObject [
	sourceCodeData := anObject
]
