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
	data components: array second asNumber.
	data classes: array third asNumber.
	data classes: array fourth asNumber.
	^ data
]

{ #category : #accessing }
RTSourceCodeData >> classes [

	^ classes
]

{ #category : #accessing }
RTSourceCodeData >> classes: anObject [

	classes := anObject
]

{ #category : #accessing }
RTSourceCodeData >> components [

	^ components
]

{ #category : #accessing }
RTSourceCodeData >> components: anObject [

	components := anObject
]

{ #category : #accessing }
RTSourceCodeData >> methods [

	^ methods
]

{ #category : #accessing }
RTSourceCodeData >> methods: anObject [

	methods := anObject
]
