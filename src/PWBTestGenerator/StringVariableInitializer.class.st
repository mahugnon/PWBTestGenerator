Class {
	#name : #StringVariableInitializer,
	#superclass : #PWBVariableInitializer,
	#category : #'PWBTestGenerator-VariableInitializers'
}

{ #category : #'as yet unclassified' }
StringVariableInitializer class >> accept: aMrlParameter [
	^ aMrlParameter parameterType name asLowercase = 'string'
]

{ #category : #printing }
StringVariableInitializer class >> acceptType: aTypeName [
	^ aTypeName asLowercase = 'string'
]

{ #category : #printing }
StringVariableInitializer >> printValue: aString [
	^ '"' , aString , '"'
]

{ #category : #resolving }
StringVariableInitializer >> rightSideOn: stream [
	^ stream
		<< '"';
		<< focus parameter_before_value mrlValue;
		<< '"';
		crlf
]
