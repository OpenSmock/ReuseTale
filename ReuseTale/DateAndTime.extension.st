Extension { #name : #DateAndTime }

{ #category : #'*ReuseTale' }
DateAndTime class >> fromStringDDMMYYYY: aString [ 
	"self fromStringDDMMYYYY: '24 01 2020'"

	| array newString |
	array := aString substrings: ' '.
	newString := (array at: 2),' ',(array at: 1),' ',(array at: 3).

	^ self readFrom: newString readStream
]
