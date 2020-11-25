Class {
	#name : #NilValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #visiting }
NilValueSolver class >> accept: aString [
	^ false
]

{ #category : #resolving }
NilValueSolver >> resolve: aString [
	^ 'SetNull(' , aString asString , ')'
]
