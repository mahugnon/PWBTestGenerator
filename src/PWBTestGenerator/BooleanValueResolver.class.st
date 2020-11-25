Class {
	#name : #BooleanValueResolver,
	#superclass : #PWBTypeValueResolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
BooleanValueResolver class >> accept: aTypeName [
	^ aTypeName asLowercase = 'boolean'
]

{ #category : #resolving }
BooleanValueResolver >> resolve: aString [
	^ aString
]
