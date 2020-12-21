Class {
	#name : #AnyValueVariableInitializer,
	#superclass : #PWBVariableInitializer,
	#category : #'PWBTestGenerator-VariableInitializers'
}

{ #category : #'as yet unclassified' }
AnyValueVariableInitializer class >> accept: aMrlParameter [
	^ aMrlParameter parameterType name asLowercase = 'any'
]

{ #category : #printing }
AnyValueVariableInitializer class >> acceptType: aTypeName [
	^ aTypeName asLowercase = 'any'
]

{ #category : #printing }
AnyValueVariableInitializer >> printValue: aString [
	^ aString
]

{ #category : #resolving }
AnyValueVariableInitializer >> rightSideOn: stream [
	^ stream
		nextPut: $";
		<< focus parameter_before_value mrlValue;
		nextPut: $";
		crlf
]
