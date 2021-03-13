"
A RTPrototypeDataRepositoryTest is a test class for testing the behavior of RTPrototypeDataRepository
"
Class {
	#name : #RTPrototypeDataRepositoryTest,
	#superclass : #RTTestCase,
	#instVars : [
		'repository'
	],
	#category : #'ReuseTale-Tests-model'
}

{ #category : #private }
RTPrototypeDataRepositoryTest >> repository [

	^repository
]

{ #category : #private }
RTPrototypeDataRepositoryTest >> setUp [

	super setUp.
	repository := RTPrototypeDataRepository new. 
	repository prototypes addAll: self prototypes.
	self subSystems do:[ :e | repository subSystems at: e name put: e ].
]

{ #category : #private }
RTPrototypeDataRepositoryTest >> tearDown [

	repository := nil.

	super tearDown.
]

{ #category : #test }
RTPrototypeDataRepositoryTest >> testNbOfUsesForSubSystem [

	self assert: (self repository nbOfUsesForSubSystem: (self subSystems first name)) equals: 2.
	self assert: (self repository nbOfUsesForSubSystem: (self subSystems second name)) equals: 1.
]

{ #category : #test }
RTPrototypeDataRepositoryTest >> testPrototypes [

	self assert: self repository prototypes size equals: 2
]

{ #category : #test }
RTPrototypeDataRepositoryTest >> testSubSystems [

	self assert: self repository subSystems size equals: 2
]
