Class {
	#name : #NilVariableInitializer,
	#superclass : #PWBVariableInitializer,
	#category : #'PWBTestGenerator-VariableInitializers'
}

{ #category : #printing }
NilVariableInitializer class >> accept: aMrlParameter [
	^ false
]

{ #category : #printing }
NilVariableInitializer class >> acceptType: aTypeName [
	^ false
]

{ #category : #resolving }
NilVariableInitializer >> printParameter: aMrlParameter on: stream [
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
NilVariableInitializer >> printValue: aString [
	^ 'SetNull("' , aString asString , '")'
]

{ #category : #resolving }
NilVariableInitializer >> rightSideOn: stream [
	^ stream
		<< 'SetNull("';
		<< focus parameter_before_value mrlValue asString;
		<< '")';
		crlf
]
