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

{ #category : #resolving }
NilValueSolver >> printParameter: aMrlParameter on: stream [
	^ stream
		<< 'SetNull(';
		<< 'l';
		<<
			(aMrlParameter parameter_name
				copyFrom: 2
				to: aMrlParameter parameter_name size);
		<< ')';
		crlf
]

{ #category : #printing }
NilValueSolver >> printValue: aString [
	^ 'SetNull("' , aString asString , '")'
]

{ #category : #resolving }
NilValueSolver >> rightSideOn: stream [
	^ stream
		<< 'SetNull("';
		<< focus parameter_before_value mrlValue asString;
		<< '")';
		crlf
]
