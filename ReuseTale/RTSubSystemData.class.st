Class {
	#name : #RTSubSystemData,
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

{ #category : #accessing }
RTSubSystemData >> description [

	^ description
]

{ #category : #accessing }
RTSubSystemData >> description: anObject [

	description := anObject
]

{ #category : #accessing }
RTSubSystemData >> firstVersionDate [

	^ firstVersionDate
]

{ #category : #accessing }
RTSubSystemData >> firstVersionDate: anObject [

	firstVersionDate := anObject
]

{ #category : #accessing }
RTSubSystemData >> mostRecentVersionDate [

	^ mostRecentVersionDate
]

{ #category : #accessing }
RTSubSystemData >> mostRecentVersionDate: anObject [

	mostRecentVersionDate := anObject
]

{ #category : #accessing }
RTSubSystemData >> name [

	^ name
]

{ #category : #accessing }
RTSubSystemData >> name: anObject [

	name := anObject
]

{ #category : #accessing }
RTSubSystemData >> nbDevelopers [

	^ nbDevelopers
]

{ #category : #accessing }
RTSubSystemData >> nbDevelopers: anObject [

	nbDevelopers := anObject
]

{ #category : #printing }
RTSubSystemData >> printOn: aStream [
	aStream << self name
]

{ #category : #accessing }
RTSubSystemData >> publications [

	^ publications
]

{ #category : #accessing }
RTSubSystemData >> publications: anObject [

	publications := anObject
]

{ #category : #accessing }
RTSubSystemData >> usagesInPrototypes [

	^ usagesInPrototypes
]

{ #category : #accessing }
RTSubSystemData >> usagesInPrototypes: anObject [

	usagesInPrototypes := anObject
]
