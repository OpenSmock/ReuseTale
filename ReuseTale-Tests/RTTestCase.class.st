Class {
	#name : #RTTestCase,
	#superclass : #TestCase,
	#instVars : [
		'subSystems',
		'prototypes'
	],
	#category : #'ReuseTale-Tests-model'
}

{ #category : #private }
RTTestCase >> createDatas [
	| prototype protoData subSystemAData subSystemA subSystemBData subSystemB prototype2 |
	prototypes := OrderedCollection new.
	subSystems := OrderedCollection new.
	
	protoData := RTSourceCodeData new.
	protoData classes: 20; components: 10; methods: 100.
	subSystemAData := RTSourceCodeData new classes: 2; components: 1; methods: 10; yourself.
	subSystemBData := RTSourceCodeData new classes: 3; components: 2; methods: 20; yourself.
	
	subSystemA := RTSubSystemData new name: 'subSystemA'; sourceCodeData: subSystemAData; nbDevelopers: 1; yourself.
	subSystemB := RTSubSystemData new name: 'subSystemB'; sourceCodeData: subSystemBData; nbDevelopers: 3; yourself.
	
	prototype := RTPrototypeData new sourceCodeData: protoData.
	prototype nbDevelopers: 2; name: 'protoA'.
	prototype addSubSystem: subSystemA; addSubSystem: subSystemB.
	
	prototype2 := RTPrototypeData new sourceCodeData: protoData.
	prototype2 nbDevelopers: 4; name: 'protoB'.
	prototype2 addSubSystem: subSystemA.
	
	prototypes add: prototype.
	prototypes add: prototype2.
	subSystems add: subSystemA.
	subSystems add: subSystemB. 
]

{ #category : #private }
RTTestCase >> prototypes [

	^prototypes
]

{ #category : #private }
RTTestCase >> setUp [

	super setUp.
	self createDatas.
]

{ #category : #private }
RTTestCase >> subSystems [

	^subSystems
]

{ #category : #private }
RTTestCase >> tearDown [

	prototypes removeAll.
	prototypes := nil.
	
	subSystems removeAll.
	subSystems := nil.

	super tearDown.
]
