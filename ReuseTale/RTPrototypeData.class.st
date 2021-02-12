Class {
	#name : #RTPrototypeData,
	#superclass : #Object,
	#instVars : [
		'name',
		'subSystems',
		'prototypeData'
	],
	#category : #ReuseTale
}

{ #category : #'instance creation' }
RTPrototypeData class >> fromRawData: array [

	| protoData |
	protoData := self new.
	protoData name: array first first.
	protoData prototypeData: (RTData fromArray: array first).
	2 to: array size do: [ :i | 
		| subSystem |
		subSystem := RTPrototypeDataRepository subSystems at:
			             (array at: i) first.
		protoData addSubSystem: subSystem withData: (array at: i) ].
	^ protoData
]

{ #category : #adding }
RTPrototypeData >> addSubSystem: aRTSubSystemData withData: aRTData [

	self subSystems at: aRTSubSystemData put: aRTData
]

{ #category : #accessing }
RTPrototypeData >> name [

	^ name
]

{ #category : #accessing }
RTPrototypeData >> name: anObject [

	name := anObject
]

{ #category : #printing }
RTPrototypeData >> printOn: aStream [
	aStream << self name
]

{ #category : #accessing }
RTPrototypeData >> prototypeData [

	^ prototypeData
]

{ #category : #accessing }
RTPrototypeData >> prototypeData: anObject [

	prototypeData := anObject
]

{ #category : #accessing }
RTPrototypeData >> subSystems [

	^ subSystems ifNil: [ subSystems := Dictionary new ]
]
