Class {
	#name : #RTData,
	#superclass : #Object,
	#instVars : [
		'name',
		'sourceCodeDataHistory',
		'publications',
		'developers',
		'nbDevelopers',
		'mostRecentVersionDate',
		'firstVersionDate',
		'description'
	],
	#category : #'ReuseTale-model'
}

{ #category : #api }
RTData >> addDeveloper: anId [

	self developers add: anId
]

{ #category : #api }
RTData >> addSourceCodeData: aRTSourceCodeData dateTime: aDateTime [
	
	aDateTime ifNil:[self error:'Date should be not nil'].
	aRTSourceCodeData ifNil:[self error:'Source code datas should be not nil'].
	self sourceCodeDataHistory at: aDateTime put: aRTSourceCodeData
]

{ #category : #accessing }
RTData >> description [

	^ description
]

{ #category : #accessing }
RTData >> description: anObject [

	description := anObject
]

{ #category : #accessing }
RTData >> developers [
	developers ifNil:[developers := Set new].
	^ developers
]

{ #category : #accessing }
RTData >> developers: anObject [
	developers := anObject
]

{ #category : #accessing }
RTData >> firstVersionDate [

	^ firstVersionDate
]

{ #category : #accessing }
RTData >> firstVersionDate: anObject [

	firstVersionDate := anObject
]

{ #category : #api }
RTData >> getSourceCodeDataHistoryAtDateTime: aDateTime [

	^self sourceCodeDataHistory at: aDateTime ifAbsent:[nil]
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
	nbDevelopers ifNotNil: [ ^ nbDevelopers ].
	^ self developers size
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
	"return more recent source code data"
	| moreRecentDate |
	moreRecentDate := (sourceCodeDataHistory keys asSortedCollection sort: [ :a :b | a < b ]) last.
	^ sourceCodeDataHistory at: moreRecentDate
]

{ #category : #accessing }
RTData >> sourceCodeDataHistory [

	sourceCodeDataHistory ifNil:[sourceCodeDataHistory := Dictionary new].
	^ sourceCodeDataHistory
]

{ #category : #accessing }
RTData >> sourceCodeDataHistory: anObject [
	sourceCodeDataHistory := anObject
]
