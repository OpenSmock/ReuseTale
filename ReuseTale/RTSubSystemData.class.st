Class {
	#name : #RTSubSystemData,
	#superclass : #RTData,
	#category : #'ReuseTale-model'
}

{ #category : #accessing }
RTSubSystemData >> id [

	^ self name readStream
		  upTo: Character space;
		  upToEnd
]

{ #category : #accessing }
RTSubSystemData >> idWithName [

	^ self id , ' ' , self description
]

{ #category : #printing }
RTSubSystemData >> printOn: aStream [
	aStream << self name
]

{ #category : #printing }
RTSubSystemData >> printStatisticsOn: stream forPrototype: aPrototype [

	| data |
	data := self getSourceCodeDataHistoryAtDateTime:
		        aPrototype mostRecentVersionDate.
	stream << self description.
	stream << '* & '.
	stream << data components printString.
	stream << ' & '.
	stream << (self
		 print:
		 (self percentOf: data components in: aPrototype nbTotalComponents)
		 limited: 5).
	stream << ' & '.
	stream << data classes printString.
	stream << ' & '.
	stream << (self
		 print: (self percentOf: data classes in: aPrototype nbTotalClasses)
		 limited: 5).
	stream << '\\'.
	stream cr
]

{ #category : #printing }
RTSubSystemData >> reuseInPrototypes [

	^ RTPrototypeDataRepository prototypes
		  inject: 0
		  into: [ :sum :prototype | 
			  sum
			  +
				  ((prototype subSystems anySatisfy: [ :e | e name = self name ])
					   ifTrue: [ 1 ]
					   ifFalse: [ 0 ]) ]
]
