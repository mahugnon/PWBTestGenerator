Class {
	#name : #BooleanValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
BooleanValueSolver class >> accept: aTypeName [
	^ aTypeName asLowercase = 'boolean'
]

{ #category : #resolving }
BooleanValueSolver >> resolve: aString [
	^ aString
]
