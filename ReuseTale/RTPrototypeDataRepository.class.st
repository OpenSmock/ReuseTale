Class {
	#name : #RTPrototypeDataRepository,
	#superclass : #Object,
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
	"splitting into each prototypeprototype"
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
		subSystem firstVersionDate:
			((subSystemDataArray at: 4) at: colIndex).
		subSystem mostRecentVersionDate:
			((subSystemDataArray at: 5) at: colIndex).
		subSystem nbDevelopers:
			((subSystemDataArray at: 6) at: colIndex) asNumber.
		self subSystems at: subSystem name put: subSystem ]
]

{ #category : #accessing }
RTPrototypeDataRepository class >> current [

	^ current ifNil: [ current := Dictionary new ]
]

{ #category : #'building ui' }
RTPrototypeDataRepository class >> openFileToBuildPrototypesData [
	<script>
	| window filename |
	window :=FileDialogWindow basicNew initialize validExtensions: #('csv') ; title: 'Select the prototypes data file'; answerPathName.
	filename := (World openModal: window) answer.
	filename ifNil:[^self].
	
	self buildPrototypesDataFromFilename: filename asFileReference.
	
	self prototypes notEmpty ifTrue:[
		self inform: '[ReuseTale] Prototypes data import done'.	
	] ifFalse:[
		self inform: '[ReuseTale] Prototypes import error'.	
	].
]

{ #category : #'building ui' }
RTPrototypeDataRepository class >> openFileToBuildSubSystemsData [
	<script>
	| window filename |
	window :=FileDialogWindow basicNew initialize validExtensions: #('csv') ; title: 'Select the subsystems data file'; answerPathName.
	filename := (World openModal: window) answer.
	filename ifNil:[^self].
	
	self buildSubSystemsDataFromFilename: filename asFileReference.
	
	self subSystems notEmpty ifTrue:[
		self inform: '[ReuseTale] Subsystems data import done'.	
	] ifFalse:[
		self inform: '[ReuseTale] Subsystems import error'.	
	].
]

{ #category : #accessing }
RTPrototypeDataRepository class >> prototypes [
	<script:'self prototypes inspect'>
	^ self current at: #prototypes ifAbsentPut: [ 
		  SortedCollection new
			  sortBlock: [ :a :b | a name < b name ];
			  yourself ]
]

{ #category : #building }
RTPrototypeDataRepository class >> reset [
	<script>
	current := nil
]

{ #category : #accessing }
RTPrototypeDataRepository class >> subSystems [
	<script:'self subSystems inspect'>
	^ self current at: #subSystems ifAbsentPut: [ Dictionary new ]
]
