Class {
	#name : #BooleanValueResolver,
	#superclass : #PWBTypeValueResolver,
	#category : #'PWBTestsGenerator-PWBTestUnitStrategy'
}

{ #category : #'as yet unclassified' }
BooleanValueResolver class >> accept: aTypeName [
	^ aTypeName asLowercase = 'boolean'
]

{ #category : #resolving }
BooleanValueResolver >> resolve: aString [
	^ aString
]
