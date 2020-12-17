Class {
	#name : #DateValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
DateValueSolver class >> accept: aMrlParameter [
	^ aMrlParameter parameterType name asLowercase = 'date'
]

{ #category : #printing }
DateValueSolver class >> acceptType: aTypeName [
	^ aTypeName asLowercase = 'date'
]

{ #category : #printing }
DateValueSolver >> printValue: aString [
	^ 'date("' , aString , '")'
]

{ #category : #resolving }
DateValueSolver >> rightSideOn: stream [
	^ stream
		<< 'date("';
		<< focus parameter_before_value mrlValue;
		<< '")';
		crlf
]
