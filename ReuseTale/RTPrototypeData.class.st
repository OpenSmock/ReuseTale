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
	protoData firstVersionDate: ((array first at: 6) ifNotNil:[ :e | (DateAndTime fromStringDDMMYYYY: e)]).
	protoData mostRecentVersionDate: ((array first at: 7) ifNotNil:[ :e | (DateAndTime fromStringDDMMYYYY: e)]).
	(array first at: 8) ifNotNil:[ :e | (e splitOn: Character space) do:[ :f | f ifNotEmpty:[ protoData addDeveloper: f asNumber]]].
	(array first at: 9) ifNotNil:[ :e | protoData publications: e asNumber].
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
RTPrototypeData >> fullStatisticsLatexLineColoredAs: colorName counter: counter [
	|stream|
	stream := WriteStream on: String new.
	colorName ifNotNil:[
		stream << '\rowcolor{'.
		stream << colorName.
		stream << '}'.].
	stream << '('.
	stream << counter printString.
	stream << ') '.
	stream << self name last asString. 
	stream << '& '.
	stream << self nbSubSystems printString.
	stream << '& '.
	stream << self nbNewComponents printString. 
	stream << ' new ('.
	stream << (self print: self percentOfNewComponents limited: 5).
	stream << '\%)& '.
	stream << self nbNewClasses printString. 
	stream << ' new ('.
	stream << (self print: self percentOfNewClasses limited: 5).
	stream << '\%)'.	
	stream << ' \\'. 
	stream cr.
	
	colorName ifNotNil:[
		stream << '\rowcolor{'.
		stream << colorName.
		stream << '}'.].
	stream << '\textit{'.
	stream << self years.
	stream << '} & & '. 
	stream << self nbReusedComponents printString. 
	stream << ' reused ('.
	stream << (self print: self percentOfReusedComponents limited: 5).
	stream << '\%) & '.
	stream << self nbReusedClasses printString. 
	stream << ' reused ('.
	stream << (self print: self percentOfReusedClasses limited: 5).
	stream << '\%)'.
	stream << ' \\'.
	^stream contents

]

{ #category : #statistics }
RTPrototypeData >> nbNewClasses [

	^ self nbTotalClasses - self nbReusedClasses
]

{ #category : #statistics }
RTPrototypeData >> nbNewComponents [

	^ self nbTotalComponents - self nbReusedComponents
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

{ #category : #statistics }
RTPrototypeData >> percentOfNewClasses [

	^ ((self nbNewClasses /  self nbTotalClasses) asFloat * 100) roundDownTo: 0.01 
]

{ #category : #statistics }
RTPrototypeData >> percentOfNewComponents [

	^ ((self nbNewComponents /  self nbTotalComponents) asFloat * 100) roundDownTo: 0.01
]

{ #category : #statistics }
RTPrototypeData >> percentOfReusedClasses [

	^ ((self nbReusedClasses /  self nbTotalClasses) asFloat * 100 )roundDownTo: 0.01 
]

{ #category : #statistics }
RTPrototypeData >> percentOfReusedComponents [

	^ ((self nbReusedComponents /  self nbTotalComponents) asFloat * 100) roundDownTo: 0.01
]

{ #category : #printing }
RTPrototypeData >> print: anObject limited: limit [

	^ self
		  printStringLimitedTo: limit
		  using: [ :s | anObject printOn: s ]
]

{ #category : #printing }
RTPrototypeData >> printOn: aStream [
	aStream << self name
]

{ #category : #printing }
RTPrototypeData >> printStringLimitedTo: limit using: printBlock [

	"Answer a String whose characters are a description of the receiver
	produced by given printBlock. It ensures the result will be not bigger than given limit"

	| limitedString |
	limitedString := String streamContents: printBlock limitedTo: limit.
	limitedString size < limit ifTrue: [ ^ limitedString ].
	^ limitedString
]

{ #category : #accessing }
RTPrototypeData >> subSystems [

	^ subSystems ifNil: [ subSystems := SortedCollection sortBlock:[ :a :b | (a name) < (b name) ] ]
]

{ #category : #statistics }
RTPrototypeData >> usesSubSystem: aSubSystemName [

	^(self subSystems detect:[ :e | e name = aSubSystemName ] ifNone:[nil]) notNil. 
	
]
