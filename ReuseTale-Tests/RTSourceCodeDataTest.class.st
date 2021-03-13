"
A RTSourceCodeDataTest is a test class for testing the behavior of RTSourceCodeData
"
Class {
	#name : #RTSourceCodeDataTest,
	#superclass : #TestCase,
	#instVars : [
		'sourceCodeData'
	],
	#category : #'ReuseTale-Tests-model'
}

{ #category : #running }
RTSourceCodeDataTest >> setUp [
	super setUp.
	
	sourceCodeData := RTSourceCodeData new.
]

{ #category : #running }
RTSourceCodeDataTest >> tearDown [

	sourceCodeData := nil.
	super tearDown.
]

{ #category : #test }
RTSourceCodeDataTest >> testClasses [

	self assert: sourceCodeData classes equals: 0
]

{ #category : #test }
RTSourceCodeDataTest >> testComponents [

	self assert: sourceCodeData components equals: 0
]

{ #category : #test }
RTSourceCodeDataTest >> testMethods [

	self assert: sourceCodeData methods equals: 0
]
