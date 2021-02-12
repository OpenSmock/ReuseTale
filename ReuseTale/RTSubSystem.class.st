Class {
	#name : #RTSubSystem,
	#superclass : #Object,
	#instVars : [
		'name',
		'publications',
		'firstVersionDate',
		'mostRecentVersionDate',
		'nbDevelopers',
		'usagesInPrototypes',
		'description'
	],
	#category : #'ReuseTale-model'
}

{ #category : #'instance creation' }
RTSubSystem class >> newFrom: csvData [
]

{ #category : #accessing }
RTSubSystem >> description [

	^ description
]

{ #category : #accessing }
RTSubSystem >> description: anObject [

	description := anObject
]

{ #category : #accessing }
RTSubSystem >> firstVersionDate [

	^ firstVersionDate
]

{ #category : #accessing }
RTSubSystem >> firstVersionDate: anObject [

	firstVersionDate := anObject
]

{ #category : #accessing }
RTSubSystem >> mostRecentVersionDate [

	^ mostRecentVersionDate
]

{ #category : #accessing }
RTSubSystem >> mostRecentVersionDate: anObject [

	mostRecentVersionDate := anObject
]

{ #category : #accessing }
RTSubSystem >> name [

	^ name
]

{ #category : #accessing }
RTSubSystem >> name: anObject [

	name := anObject
]

{ #category : #accessing }
RTSubSystem >> nbDevelopers [

	^ nbDevelopers
]

{ #category : #accessing }
RTSubSystem >> nbDevelopers: anObject [

	nbDevelopers := anObject
]

{ #category : #accessing }
RTSubSystem >> publications [

	^ publications
]

{ #category : #accessing }
RTSubSystem >> publications: anObject [

	publications := anObject
]

{ #category : #accessing }
RTSubSystem >> usagesInPrototypes [

	^ usagesInPrototypes
]

{ #category : #accessing }
RTSubSystem >> usagesInPrototypes: anObject [

	usagesInPrototypes := anObject
]
