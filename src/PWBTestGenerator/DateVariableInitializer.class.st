Class {
	#name : #DateVariableInitializer,
	#superclass : #PWBVariableInitializer,
	#category : #'PWBTestGenerator-VariableUtilities'
}

{ #category : #'as yet unclassified' }
DateVariableInitializer class >> accept: aMrlParameter [
	^ aMrlParameter parameterType name asLowercase = 'date'
]

{ #category : #printing }
DateVariableInitializer class >> acceptType: aTypeName [
	^ aTypeName asLowercase = 'date'
]

{ #category : #printing }
DateVariableInitializer >> printValue: aString [
	^ 'date("' , aString , '")'
]

{ #category : #resolving }
DateVariableInitializer >> rightSideOn: stream [
	^ stream
		<< 'date("';
		<< focus parameter_before_value mrlValue;
		<< '")';
		crlf
]
