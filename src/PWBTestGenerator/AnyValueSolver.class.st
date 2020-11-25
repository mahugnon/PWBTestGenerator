Class {
	#name : #AnyValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
AnyValueSolver class >> accept: aTypeName [
	^ aTypeName asLowercase = 'any'
]

{ #category : #resolving }
AnyValueSolver >> resolve: aString [
	^ aString
]
