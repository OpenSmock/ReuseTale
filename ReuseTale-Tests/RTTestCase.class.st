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
	| prototype protoData subSystemAData subSystemA subSystemBData subSystemB prototype2 subSystemBData2 now |
	prototypes := OrderedCollection new.
	subSystems := OrderedCollection new.
	now := DateAndTime now.
	
	protoData := RTSourceCodeData new.
	protoData classes: 20; components: 10; methods: 100.
	subSystemAData := RTSourceCodeData new classes: 2; components: 1; methods: 10; yourself.
	subSystemBData := RTSourceCodeData new classes: 3; components: 2; methods: 20; yourself.
	subSystemBData2 := RTSourceCodeData new classes: 0; components: 0; methods: 0; yourself.
	
	subSystemA := RTSubSystemData new name: 'subSystemA'; addSourceCodeData: subSystemAData dateTime: now; nbDevelopers: 1; yourself.
	subSystemB := RTSubSystemData new name: 'subSystemB'; addSourceCodeData: subSystemBData dateTime: now; nbDevelopers: 3; addSourceCodeData: subSystemBData2 dateTime: (DateAndTime fromStringDDMMYYYY: '01 01 2020'); nbDevelopers: 3; yourself.
	
	prototype := RTPrototypeData new addSourceCodeData: protoData dateTime: now; yourself.
	prototype addDeveloper: 1; addDeveloper: 2.
	prototype name: 'protoA'.
	prototype mostRecentVersionDate: now.
	prototype addSubSystem: subSystemA; addSubSystem: subSystemB.
	
	prototype2 := RTPrototypeData new addSourceCodeData: protoData dateTime: now; yourself.
	prototype2 addDeveloper: 1; addDeveloper: 2; addDeveloper: 3; addDeveloper: 4. 
	prototype2 name: 'protoB'.
	prototype2 mostRecentVersionDate: now.
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

{ #category : #tests }
RTTestCase >> testDateAndTimeFromStringDDMMYYYY [
	| dateTime |
	dateTime := DateAndTime year: 2020 month: 01 day: 24.
	self assert: (DateAndTime fromStringDDMMYYYY: '24 01 2020') equals: dateTime. 
	
	dateTime := DateAndTime year: 1900 month: 01 day: 01.
	self assert: (DateAndTime fromStringDDMMYYYY: '01 01 1900') equals: dateTime. 
]
