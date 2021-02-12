Class {
	#name : #BaselineOfReuseTale,
	#superclass : #BaselineOf,
	#category : #BaselineOfReuseTale
}

{ #category : #baselines }
BaselineOfReuseTale >> baseline: spec [

	<baseline>
	spec
		baseline: 'NeoCSV'
		with: [ spec repository: 'github://svenvc/NeoCSV/repository' ].
	spec
		baseline: 'ReuseTale'
		with: [ spec repository: 'github://StevenCostiou/ReuseTale' ]
]
