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
		subSystem usagesInPrototypes:
			((subSystemDataArray at: 7) at: colIndex) asNumber.
		self subSystems at: subSystem name put: subSystem ]
]

{ #category : #accessing }
RTPrototypeDataRepository class >> current [

	^ current ifNil: [ current := Dictionary new ]
]

{ #category : #accessing }
RTPrototypeDataRepository class >> prototypes [

	^ self current at: #prototypes ifAbsentPut: [ 
		  SortedCollection new
			  sortBlock: [ :a :b | a name < b name ];
			  yourself ]
]

{ #category : #building }
RTPrototypeDataRepository class >> reset [

	current := nil
]

{ #category : #accessing }
RTPrototypeDataRepository class >> subSystems [

	^ self current at: #subSystems ifAbsentPut: [ Dictionary new ]
]
