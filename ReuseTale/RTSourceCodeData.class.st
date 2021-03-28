Class {
	#name : #RTSourceCodeData,
	#superclass : #Object,
	#instVars : [
		'components',
		'classes',
		'methods'
	],
	#category : #'ReuseTale-model'
}

{ #category : #'instance creation' }
RTSourceCodeData class >> fromArray: array [

	| data |
	data := self new.
	data components: (array at: 2) asNumber.
	data classes: (array at: 4) asNumber.
	data methods: (array at: 5) asNumber.
	^ data
]

{ #category : #accessing }
RTSourceCodeData >> classes [

	classes ifNil: [ classes := 0 ].
	^ classes
]

{ #category : #accessing }
RTSourceCodeData >> classes: anObject [

	classes := anObject
]

{ #category : #accessing }
RTSourceCodeData >> components [

	components ifNil: [ components := 0 ].
	^ components
]

{ #category : #accessing }
RTSourceCodeData >> components: anObject [

	components := anObject
]

{ #category : #accessing }
RTSourceCodeData >> methods [

	methods ifNil:[methods := 0].
	^ methods
]

{ #category : #accessing }
RTSourceCodeData >> methods: anObject [

	methods := anObject
]
