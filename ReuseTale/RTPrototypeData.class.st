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
	protoData firstVersionDate: ((array first at: 5) ifNotNil:[ :e | (DateAndTime fromStringDDMMYYYY: e)]).
	protoData mostRecentVersionDate: ((array first at: 6) ifNotNil:[ :e | (DateAndTime fromStringDDMMYYYY: e)]).
	(array first at: 7) ifNotNil:[ :e | (e splitOn: Character space) do:[ :f | f ifNotEmpty:[ protoData addDeveloper: f asNumber]]].
	(array first at: 8) ifNotNil:[ :e | protoData publications: e asNumber].
	protoData addSourceCodeData: (RTSourceCodeData fromArray: array first) dateTime: (protoData mostRecentVersionDate).
	2 to: array size do: [ :i |  
		| subSystem |
		subSystem := RTPrototypeDataRepository subSystems at: (array at: i) first.
		"update sub system datas"
		subSystem addSourceCodeData: (RTSourceCodeData fromArray: (array at: i)) dateTime: (protoData mostRecentVersionDate).
		protoData addSubSystem: subSystem
	].
	^ protoData
]

{ #category : #adding }
RTPrototypeData >> addSubSystem: aRTSubSystem [

	self subSystems add: aRTSubSystem
]

{ #category : #statistics }
RTPrototypeData >> nbReusedClasses [

	^self subSystems inject: 0 into: [ :sum :e | (e getSourceCodeDataHistoryAtDateTime: self mostRecentVersionDate) classes + sum ].
]

{ #category : #statistics }
RTPrototypeData >> nbReusedComponents [
	
	^self subSystems inject: 0 into: [ :sum :e | (e getSourceCodeDataHistoryAtDateTime: self mostRecentVersionDate) components + sum ].
]

{ #category : #statistics }
RTPrototypeData >> nbReusedMethods [

	^self subSystems inject: 0 into: [ :sum :e | (e getSourceCodeDataHistoryAtDateTime: self mostRecentVersionDate) methods + sum ].
]

{ #category : #statistics }
RTPrototypeData >> nbSubSystems [
	
	^self subSystems size
]

{ #category : #statistics }
RTPrototypeData >> nbTotalClasses [
	
	^self nbClasses + self nbReusedClasses
]

{ #category : #statistics }
RTPrototypeData >> nbTotalComponents [
	
	^self nbComponents + self nbReusedComponents 
]

{ #category : #statistics }
RTPrototypeData >> nbTotalMethods [
	
	^self nbMethods + self nbReusedMethods
]

{ #category : #printing }
RTPrototypeData >> printOn: aStream [
	aStream << self name
]

{ #category : #accessing }
RTPrototypeData >> subSystems [

	^ subSystems ifNil: [ subSystems := SortedCollection sortBlock:[ :a :b | (a name) < (b name) ] ]
]

{ #category : #statistics }
RTPrototypeData >> usesSubSystem: aSubSystemName [

	^(self subSystems detect:[ :e | e name = aSubSystemName ] ifNone:[nil]) notNil. 
	
]
