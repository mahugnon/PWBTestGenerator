Class {
	#name : #NilValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #printing }
NilValueSolver class >> accept: aMrlParameter [
	^ false
]

{ #category : #printing }
NilValueSolver class >> acceptType: aTypeName [
	^ false
]

{ #category : #printing }
NilValueSolver >> printValue: aString [
	^ 'SetNull("' , aString asString , '")'
]

{ #category : #resolving }
NilValueSolver >> rightSideOn: stream [
	^ stream
		<< 'SetNull("';
		<< focus parameter_before_value asString;
		<< '")';
		crlf
]
