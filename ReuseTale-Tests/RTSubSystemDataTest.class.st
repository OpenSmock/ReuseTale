"
A RTSubSystemDataTest is a test class for testing the behavior of RTSubSystemData
"
Class {
	#name : #RTSubSystemDataTest,
	#superclass : #RTTestCase,
	#category : #'ReuseTale-Tests-model'
}

{ #category : #tests }
RTSubSystemDataTest >> testSubSystemsDatas [
	| subSystem |
	subSystem := self subSystems first.
	
	self assert: subSystem nbComponents equals: 1. 
	self assert: subSystem nbClasses equals: 2.  
	self assert: subSystem nbMethods equals: 10. 

	self assert: subSystem developers asOrderedCollection isEmpty.
	self assert: subSystem nbDevelopers equals: 1.
	
	self assert: subSystem sourceCodeDataHistory size equals: 1.
]

{ #category : #tests }
RTSubSystemDataTest >> testSubSystemsDatas2 [
	| subSystem dateTime sourceCodeData |
	subSystem := self subSystems second.
	
	self assert: subSystem nbComponents equals: 2. 
	self assert: subSystem nbClasses equals: 3.  
	self assert: subSystem nbMethods equals: 20. 

	self assert: subSystem developers asOrderedCollection isEmpty.
	self assert: subSystem nbDevelopers equals: 3.
	
	self assert: subSystem sourceCodeDataHistory size equals: 2.
	dateTime := DateAndTime fromStringDDMMYYYY: '01 01 2020'.
	sourceCodeData := subSystem getSourceCodeDataHistoryAtDateTime: dateTime.
	self assert: sourceCodeData components equals: 0.
	self assert: sourceCodeData classes equals: 0.
	self assert: sourceCodeData methods equals: 0.
]
