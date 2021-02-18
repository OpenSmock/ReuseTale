Class {
	#name : #BaselineOfReuseTale,
	#superclass : #BaselineOf,
	#category : #BaselineOfReuseTale
}

{ #category : #baselines }
BaselineOfReuseTale >> baseline: spec [
	<baseline>
	"Common dependencies"
	spec baseline: 'NeoCSV' with: [ spec repository: 'github://svenvc/NeoCSV/repository' ].
	
	spec for: #common do: [ 
		
		"ReuseTale packages"
		spec package: 'ReuseTale'.
		spec package: 'ReuseTale-Tests' with: [ spec requires: #('ReuseTale') ].
		
		"Dependencies for Pharo 8"
		spec for: #'pharo8.x'do: [ 
			spec baseline: 'Roassal3' with: [ spec repository: 'github://ObjectProfile/Roassal3' ].
		]
	]
]
