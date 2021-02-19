Class {
	#name : #RTPrototypeDataRepository,
	#superclass : #Dictionary,
	#classInstVars : [
		'current'
	],
	#category : #'ReuseTale-model'
}

{ #category : #building }
RTPrototypeDataRepository class >> buildPrototypesDataFromFilename: aFileReference [
	| rawData |	
	rawData := (NeoCSVReader on: aFileReference readStream) upToEnd
		           asOrderedCollection.
	"removing header"
	rawData removeFirst.
	"splitting into each prototype"
	rawData := rawData splitOn: [ :e | e first isNil ].
	self prototypes addAll:
		(rawData collect: [ :data | RTPrototypeData fromRawData: data ])
]

{ #category : #building }
RTPrototypeDataRepository class >> buildSubSystemsDataFromFilename: aFileReference [

	| subSystemDataArray |
	subSystemDataArray := (NeoCSVReader on: aFileReference readStream)
		                      upToEnd.

	2 to: subSystemDataArray first size do: [ :colIndex | 
		| subSystem |
		subSystem := RTSubSystemData new.
		subSystem name: ((subSystemDataArray at: 1) at: colIndex).
		subSystem description: ((subSystemDataArray at: 2) at: colIndex).
		subSystem publications:
			((subSystemDataArray at: 3) at: colIndex) asNumber.
		subSystem firstVersionDate: (((subSystemDataArray at: 4) at: colIndex) ifNotNil:[ :e | (DateAndTime fromStringDDMMYYYY: e)]).
		subSystem mostRecentVersionDate: (((subSystemDataArray at: 5) at: colIndex) ifNotNil:[ :e | (DateAndTime fromStringDDMMYYYY: e)]).	
		"subSystem firstVersionDate: ((subSystemDataArray at: 4) at: colIndex).
		subSystem mostRecentVersionDate: ((subSystemDataArray at: 5) at: colIndex)."
		subSystem nbDevelopers: ((subSystemDataArray at: 6) at: colIndex) asNumber.
		self subSystems at: subSystem name put: subSystem ]
]

{ #category : #accessing }
RTPrototypeDataRepository class >> current [

	^ current ifNil: [ current := self new ]
]

{ #category : #querying }
RTPrototypeDataRepository class >> getPrototypesByYear [
	<script: 'self getPrototypesByYear inspect'>

| min max dic |
dic := Dictionary new.
min := self prototypes first mostRecentVersionDate.
max := self prototypes first mostRecentVersionDate.
self prototypes do: [  :p | min > p mostRecentVersionDate ifTrue:[min := p mostRecentVersionDate]. max < p mostRecentVersionDate ifTrue:[max := p mostRecentVersionDate ]. ].

min year to: max year do:[ :y |
		dic at: y put:  (self prototypes select: [  :e | e mostRecentVersionDate year = y ]).
	].
^dic

]

{ #category : #querying }
RTPrototypeDataRepository class >> getPrototypesFromOlderToMostRecent [
	<script: 'self getPrototypesFromOlderToMostRecent inspect'>

	^self prototypes asSortedCollection: [:a :b | a mostRecentVersionDate julianDayNumber < b mostRecentVersionDate julianDayNumber ].

]

{ #category : #accessing }
RTPrototypeDataRepository class >> inspectPrototypesByYear [
<script>
self getPrototypesByYear inspect

]

{ #category : #'building ui' }
RTPrototypeDataRepository class >> openFileToBuildPrototypesData [

	<script>
	| window filename |
	window := FileDialogWindow basicNew initialize
		          validExtensions: #( 'csv' );
		          title: 'Select the prototypes data file';
		          answerPathName.
	filename := window openModal answer.
	filename ifNil: [ ^ self ].

	self buildPrototypesDataFromFilename: filename asFileReference.

	self prototypes notEmpty
		ifTrue: [ self inform: '[ReuseTale] Prototypes data import done' ]
		ifFalse: [ self inform: '[ReuseTale] Prototypes import error' ]
]

{ #category : #'building ui' }
RTPrototypeDataRepository class >> openFileToBuildSubSystemsData [

	<script>
	| window filename |
	window := FileDialogWindow basicNew initialize
		          validExtensions: #( 'csv' );
		          title: 'Select the subsystems data file';
		          answerPathName.
	filename := window openModal answer.
	filename ifNil: [ ^ self ].

	self buildSubSystemsDataFromFilename: filename asFileReference.

	self subSystems notEmpty
		ifTrue: [ self inform: '[ReuseTale] Subsystems data import done' ]
		ifFalse: [ self inform: '[ReuseTale] Subsystems import error' ]
]

{ #category : #accessing }
RTPrototypeDataRepository class >> prototypes [
	<script:'self prototypes inspect'>
	^ self current prototypes
]

{ #category : #building }
RTPrototypeDataRepository class >> reset [
	<script>
	current := nil
]

{ #category : #accessing }
RTPrototypeDataRepository class >> subSystems [
	<script:'self subSystems inspect'>
	^ self current subSystems
]

{ #category : #statistics }
RTPrototypeDataRepository >> nbOfUsesForSubSystem: aSubSystemName [

	^self prototypes inject: 0 into:[ :sum :proto | (proto usesSubSystem: aSubSystemName) ifTrue:[sum + 1] ifFalse:[sum] ].
]

{ #category : #private }
RTPrototypeDataRepository >> prototypes [
	^ self at: #prototypes ifAbsentPut: [ 
		  SortedCollection new
			  sortBlock: [ :a :b | a name < b name ];
			  yourself ]
]

{ #category : #private }
RTPrototypeDataRepository >> subSystems [
	^ self at: #subSystems ifAbsentPut: [ Dictionary new ]
]
