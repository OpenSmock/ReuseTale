Class {
	#name : #RTSubSystemData,
	#superclass : #RTData,
	#category : #'ReuseTale-model'
}

{ #category : #accessing }
RTSubSystemData >> id [

	^ self name readStream
		  upTo: Character space;
		  upToEnd
]

{ #category : #accessing }
RTSubSystemData >> idWithName [

	^ self id , ' ' , self description
]

{ #category : #printing }
RTSubSystemData >> printOn: aStream [
	aStream << self name
]
