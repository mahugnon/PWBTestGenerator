Class {
	#name : #StringValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
StringValueSolver class >> accept: aMrlParameter [
	^ aMrlParameter parameterType name asLowercase = 'string'
]

{ #category : #printing }
StringValueSolver class >> acceptType: aTypeName [
	^ aTypeName asLowercase = 'string'
]

{ #category : #printing }
StringValueSolver >> printValue: aString [
	^ '"' , aString , '"'
]

{ #category : #resolving }
StringValueSolver >> rightSideOn: stream [
	^ stream
		<< '"';
		<< focus parameter_before_value;
		<< '"';
		crlf
]
