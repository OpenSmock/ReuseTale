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
	 
	self assert: subSystem nbDevelopers equals: 1.
]
