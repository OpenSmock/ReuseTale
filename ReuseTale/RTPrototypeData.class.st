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
		protoData addSubSystem: subSystem withData: (array at: i) ].
	^ protoData
]

{ #category : #adding }
RTPrototypeData >> addSubSystem: aRTSubSystemData withData: aRTData [

	self subSystems at: aRTSubSystemData put: aRTData
]

{ #category : #printing }
RTPrototypeData >> printOn: aStream [
	aStream << self name
]

{ #category : #accessing }
RTPrototypeData >> subSystems [

	^ subSystems ifNil: [ subSystems := Dictionary new ]
]
