Class {
	#name : #PWBTestBasicTypeInstanceVariableAssertCreator,
	#superclass : #PWBTestInstanceVariableAssertCreator,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #'as yet unclassified' }
PWBTestBasicTypeInstanceVariableAssertCreator class >> accept: anAccess [
	^ anAccess beforeValueDataobject isEmptyOrNil
]

{ #category : #'as yet unclassified' }
PWBTestBasicTypeInstanceVariableAssertCreator >> access: aMrlInstanceVariableAccess on: stream [
	stream
		<< 'this.assert(';
		<<
			(PWBVariableInitializer
				printValue: aMrlInstanceVariableAccess afterValue mrlvalue
				ofType: aMrlInstanceVariableAccess variableTypeName);
		space;
		<< '=';
		<< aMrlInstanceVariableAccess pwbTestVariableName;
		nextPut: $);
		crlf
]
