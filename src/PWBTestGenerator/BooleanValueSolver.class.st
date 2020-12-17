Class {
	#name : #BooleanValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
BooleanValueSolver class >> accept: aMrlParameter [
	^ aMrlParameter parameterType name asLowercase = 'boolean'
]

{ #category : #printing }
BooleanValueSolver class >> acceptType: aTypeName [
	^ aTypeName asLowercase = 'boolean'
]

{ #category : #printing }
BooleanValueSolver >> printValue: aString [
	^ aString
]

{ #category : #resolving }
BooleanValueSolver >> rightSideOn: stream [
	^ stream
		<< focus parameter_before_value mrlValue;
		crlf
]
