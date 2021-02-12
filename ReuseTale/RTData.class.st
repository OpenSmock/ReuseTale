Class {
	#name : #RTData,
	#superclass : #Object,
	#instVars : [
		'components',
		'classes',
		'methods'
	],
	#category : #'ReuseTale-model'
}

{ #category : #'instance creation' }
RTData class >> fromArray: array [

	| data |
	data := self new.
	data components: array second asNumber.
	data classes: array third asNumber.
	data classes: array fourth asNumber.
	^ data
]

{ #category : #accessing }
RTData >> classes [

	^ classes
]

{ #category : #accessing }
RTData >> classes: anObject [

	classes := anObject
]

{ #category : #accessing }
RTData >> components [

	^ components
]

{ #category : #accessing }
RTData >> components: anObject [

	components := anObject
]

{ #category : #accessing }
RTData >> methods [

	^ methods
]

{ #category : #accessing }
RTData >> methods: anObject [

	methods := anObject
]
