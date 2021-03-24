"
<keyClass>
`RSManualHorizontalTick` defines manual ticks for the horizontal axis. It is a decoration that can be added to a `RSChart`.

*Responsibility*: define, customize, and render ticks

*Collaborators*: `RSManualHorizontalTick` is added to `RSChart`

Public API and Key Messages

addValue: aValue
	Shall add a value to the list of manual horizontal ticks.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	manualValues:		Manual values for ticks

*Example*:
```Smalltalk
| manualTicks |
manualTicks := RSManualHorizontalTick new
		               labelConversion: [ :val | 
			               (Date julianDayNumber: val) year ];
		               useDiagonalLabel; yourself.
manualTicks add: Date today julianDayNumber.
manualTicks add: Date tomorrow julianDayNumber.
```
"
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
	self numberOfTicks: self manualValues size.
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
