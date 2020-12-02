Class {
	#name : #AnyValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
AnyValueSolver class >> accept: aMrlParameter [
	^ aMrlParameter parameterType name asLowercase = 'any'
]

{ #category : #printing }
AnyValueSolver class >> acceptType: aTypeName [
	^ aTypeName asLowercase = 'any'
]

{ #category : #printing }
AnyValueSolver >> printValue: aString [
	^ aString
]

{ #category : #resolving }
AnyValueSolver >> rightSideOn: stream [
	^ stream
		<< focus parameter_before_value;
		crlf
]
