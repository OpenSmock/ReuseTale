Class {
	#name : #RTDataTest,
	#superclass : #TestCase,
	#category : #ReuseTale
}

{ #category : #tests }
RTDataTest >> testSubsystemsHaveCommitsSinceTheirCreationDate [

	| ssys ssyMissingDates |
	ssys := RTPrototypeDataRepository subSystems reject: [ :s | 
		        | firstDate |
		        firstDate := s firstVersionDate year.
		        firstDate < 2010 ifTrue: [ firstDate := 2010 ].

		        s sourceCodeDataHistory keys anySatisfy: [ :date | 
			        date year <= firstDate ] ].
	ssyMissingDates := Dictionary new.
	ssys collect: [ :s | 
		ssyMissingDates at: s put: (Array
				 with: 'First version year' -> s firstVersionDate year
				 with: 'First publication/commit year'
					 -> s sourceCodeDataHistory keys asSortedCollection first year) ].
	self assertEmpty: ssyMissingDates
]
