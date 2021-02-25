Class {
	#name : #RSManualHorizontalTick,
	#superclass : #RSHorizontalTick,
	#instVars : [
		'manualValues'
	],
	#category : #'ReuseTale-model'
}

{ #category : #accessing }
RSManualHorizontalTick >> addValue: aValue [
	self manualValues add: aValue.
]

{ #category : #accessing }
RSManualHorizontalTick >> manualValues [
manualValues ifNil: [ manualValues := OrderedCollection new ].
^manualValues 
]

{ #category : #rendering }
RSManualHorizontalTick >> renderIn: canvas [
	| ticksData |
	ticks := self manualValues collect: [ :value | self createTickLineFor: value ].
	canvas addAll: ticks.
	self configuration shouldHaveLabels ifFalse: [ ^ self ].
	labels :=  self manualValues collectWithIndex: [ :value :index | 
		self createLabelFor: value index: index ].
	canvas addAll: labels.
]
