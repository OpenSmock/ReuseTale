"
A RTDataTest is a test class for testing the behavior of RTData
"
Class {
	#name : #RTDataTest,
	#superclass : #TestCase,
	#instVars : [
		'data'
	],
	#category : #'ReuseTale-Tests-model'
}

{ #category : #running }
RTDataTest >> setUp [
	super setUp.
	
	data := RTData new.
]

{ #category : #running }
RTDataTest >> tearDown [

	data := nil.
	super tearDown.
]

{ #category : #test }
RTDataTest >> testYearsList [

	self assert: data yearsList isEmpty.
	
	data firstVersionDate: DateAndTime new.
	self assert: data yearsList size equals: 1.
	self assert: data yearsList first equals: 1901.
	
	data mostRecentVersionDate: (DateAndTime year: 2021 month: 01).
	self assert: data yearsList size equals: (2021 - 1901 + 1). "add 1 to have the first year"
	self assert: data yearsList first equals: 1901.
	self assert: data yearsList last equals: 2021.
]
