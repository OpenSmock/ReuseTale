Class {
	#name : #RTSubSystemData,
	#superclass : #RTData,
	#category : #'ReuseTale-model'
}

{ #category : #printing }
RTSubSystemData >> printOn: aStream [
	aStream << self name
]
