Class {
	#name : #PWBTestBasicTypeInstanceVariableCreator,
	#superclass : #PWBTestInstanceVariableCreator,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #visiting }
PWBTestBasicTypeInstanceVariableCreator class >> accept: anAccess [
	^ anAccess beforeValueDataobject isEmptyOrNil
]

{ #category : #'as yet unclassified' }
PWBTestBasicTypeInstanceVariableCreator >> access: acc on: stream [
	stream
		<< acc pwbTestVariableName;
		space;
		nextPut: $=;
		space;
		<<
			(PWBVariableInitializer
				printValue: acc beforeValue mrlvalue
				ofType: acc variableTypeName);
		crlf
]
