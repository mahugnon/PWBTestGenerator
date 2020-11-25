Class {
	#name : #StringValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
StringValueSolver class >> accept: aTypeName [
	^ aTypeName asLowercase ='string'
]

{ #category : #resolving }
StringValueSolver >> resolve: aString [
	^ '"' , aString , '"'
]
