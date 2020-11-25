Class {
	#name : #DateValueResolver,
	#superclass : #PWBTypeValueResolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
DateValueResolver class >> accept: aTypeName [
	^ aTypeName asLowercase = 'date'
]

{ #category : #resolving }
DateValueResolver >> resolve: aString [
	aString ifNil: [ ^ 'SetNull(' , aString asString , ')' ].
	^ 'date("' , aString , '")'
]
