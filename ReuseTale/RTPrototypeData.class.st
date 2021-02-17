Class {
	#name : #RTPrototypeData,
	#superclass : #RTData,
	#instVars : [
		'subSystems'
	],
	#category : #'ReuseTale-model'
}

{ #category : #'instance creation' }
RTPrototypeData class >> fromRawData: array [

	| protoData |
	protoData := self new.
	protoData name: array first first.
	protoData sourceCodeData: (RTSourceCodeData fromArray: array first).
	2 to: array size do: [ :i | 
		| subSystem |
		subSystem := RTPrototypeDataRepository subSystems at:
			             (array at: i) first.
		protoData addSubSystem: subSystem].
	^ protoData
]

{ #category : #adding }
RTPrototypeData >> addSubSystem: aRTSubSystem [

	self subSystems add: aRTSubSystem
]

{ #category : #statistics }
RTPrototypeData >> nbReusedClasses [

	^self subSystems inject: 0 into: [ :sum :e | e sourceCodeData classes + sum ].
]

{ #category : #statistics }
RTPrototypeData >> nbReusedComponents [
	
	^self subSystems inject: 0 into: [ :sum :e | e sourceCodeData components + sum ].
]

{ #category : #statistics }
RTPrototypeData >> nbReusedMethods [

	^self subSystems inject: 0 into: [ :sum :e | e sourceCodeData methods + sum ].
]

{ #category : #statistics }
RTPrototypeData >> nbTotalClasses [
	
	^self sourceCodeData classes + self nbReusedClasses
]

{ #category : #statistics }
RTPrototypeData >> nbTotalComponents [
	
	^self sourceCodeData components + self nbReusedComponents 
]

{ #category : #statistics }
RTPrototypeData >> nbTotalMethods [
	
	^self sourceCodeData methods + self nbReusedMethods
]

{ #category : #printing }
RTPrototypeData >> printOn: aStream [
	aStream << self name
]

{ #category : #accessing }
RTPrototypeData >> subSystems [

	^ subSystems ifNil: [ subSystems := SortedCollection sortBlock:[ :a :b | (a name) < (b name) ] ]
]
