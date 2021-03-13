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
RTData >> componentsByYear [

| min max dic |
dic := Dictionary new.
min := self sourceCodeDataHistory associations first key.
max := self sourceCodeDataHistory associations first key.
self sourceCodeDataHistory associations do: [  :p | min > p key ifTrue:[min := p key]. max < p key ifTrue:[max := p key ]. ].

min year to: max year do:[ :y |
		dic at: y put:  (self sourceCodeDataHistory associations select: [  :e | e key year = y ]).
	].
^dic



]

{ #category : #accessing }
RTData >> componentsByYearFrom: aYr1 to: aYr2 [

| min max dic |
dic := Dictionary new.
min := Date year: aYr1 day: 1.
max := Date year: aYr2 day: 1.

min year to: max year do:[ :y |
		dic at: y put:  (self sourceCodeDataHistory associations select: [  :e | e key year = y ]).
	].
^dic



]

{ #category : #accessing }
RTData >> componentsNumberByYear [

| min max dic val valNb previous |
dic := Dictionary new.
min := self sourceCodeDataHistory associations first key.
max := self sourceCodeDataHistory associations first key.
self sourceCodeDataHistory associations do: [  :p | min > p key ifTrue:[min := p key]. max < p key ifTrue:[max := p key ]. ].
	previous :=0.
min year to: max year do:[ :y |
	val :=	(self sourceCodeDataHistory associations select: [  :e | e key year = y ]).
	valNb := 0.

	val do: [  :e | valNb := valNb max: e value components  ].
	valNb = 0 ifTrue:[ dic at: y put: previous ] ifFalse: [dic at: y put: valNb.
		previous := valNb] .
	].
^dic



]

{ #category : #accessing }
RTData >> componentsNumberByYearFrom: aYr1 to: aYr2 [

| min max dic val valNb previous |
dic := Dictionary new.
min := Date year: aYr1 day: 1.
max := (Date year: aYr2 day: 1).
self sourceCodeDataHistory associations do: [  :p | min > p key ifTrue:[min := p key]. max < p key ifTrue:[max := p key ]. ].
	previous :=0.
min year to: max year do:[ :y |
	val :=	(self sourceCodeDataHistory associations select: [  :e | e key year = y ]).
	valNb := 0.

	val do: [  :e | valNb := valNb max: e value components  ].
	valNb = 0 ifTrue:[ dic at: y put: previous ] ifFalse: [dic at: y put: valNb.
		previous := valNb] .
	].
^dic



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

{ #category : #accessing }
RTData >> years [

	| stream firstYear|
	self firstVersionDate year = self mostRecentVersionDate year ifTrue: [ 
		^ self firstVersionDate year printString ].
	stream := WriteStream on: String new.
	firstYear := (self firstVersionDate year - 2000).
	firstYear < 10 ifTrue: [ stream << 0 printString.].
	stream << firstYear printString.
	stream << '/'.
	stream << (self mostRecentVersionDate year - 2000) printString.
	^ stream contents
]

{ #category : #accessing }
RTData >> yearsList [
	| oc |
	
	oc := OrderedCollection new.
	(self firstVersionDate isNil and:[self mostRecentVersionDate isNil]) ifTrue:[^oc].

	(self mostRecentVersionDate isNil or:[self firstVersionDate year = self mostRecentVersionDate year]) ifTrue: [ 
		^ Array with: self firstVersionDate year 
	].

	(self firstVersionDate year to: self mostRecentVersionDate year) do: [ :e | oc add: e ].

	^ oc
]
