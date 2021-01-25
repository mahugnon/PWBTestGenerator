Class {
	#name : #BooleanVariableInitializer,
	#superclass : #PWBVariableInitializer,
	#category : #'PWBTestGenerator-VariableUtilities'
}

{ #category : #'as yet unclassified' }
BooleanVariableInitializer class >> accept: aMrlParameter [
	^ aMrlParameter parameterType name asLowercase = 'boolean'
]

{ #category : #printing }
BooleanVariableInitializer class >> acceptType: aTypeName [
	^ aTypeName asLowercase = 'boolean'
]

{ #category : #printing }
BooleanVariableInitializer >> printValue: aString [
	^ aString
]

{ #category : #resolving }
BooleanVariableInitializer >> rightSideOn: stream [
	^ stream
		<< focus parameter_before_value mrlValue;
		crlf
]
