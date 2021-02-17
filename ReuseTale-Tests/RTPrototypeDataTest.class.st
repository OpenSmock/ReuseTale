"
A RTPrototypeDataTest is a test class for testing the behavior of RTPrototypeData
"
Class {
	#name : #RTPrototypeDataTest,
	#superclass : #RTTestCase,
	#category : #'ReuseTale-Tests-model'
}

{ #category : #tests }
RTPrototypeDataTest >> testDatas [
	| prototype |
	prototype := self prototypes first.
	
	self assert: prototype nbComponents equals: 10. 
	self assert: prototype nbClasses equals: 20.  
	self assert: prototype nbMethods equals: 100. 
	 
	self assert: prototype nbDevelopers equals: 2.
	self assert: prototype nbSubSystems equals: 2.
]

{ #category : #tests }
RTPrototypeDataTest >> testReusedDatas [
	| prototype |
	prototype := self prototypes first.
	
	self assert: prototype nbReusedComponents equals: 3. 
	self assert: prototype nbReusedClasses equals: 5.  
	self assert: prototype nbReusedMethods equals: 30. 
]

{ #category : #tests }
RTPrototypeDataTest >> testTotalDatas [
	| prototype |
	prototype := self prototypes first.

	self assert: prototype nbTotalComponents equals: 13. 
	self assert: prototype nbTotalClasses equals: 25. 
	self assert: prototype nbTotalMethods equals: 130.
]
