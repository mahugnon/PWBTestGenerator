Class {
	#name : #PWBAbstractParametersUnitAssertion,
	#superclass : #Object,
	#instVars : [
		'behaviorReturnValue',
		'timestamp',
		'functionUnderTest',
		'pwbParameters',
		'behaviorAccesses'
	],
	#category : #'PWBTestGenerator-Assertions'
}

{ #category : #adding }
PWBAbstractParametersUnitAssertion >> addAccess: aMrlAccess [
	behaviorAccesses add: aMrlAccess
]

{ #category : #printing }
PWBAbstractParametersUnitAssertion >> assertNilOn: stream [
	stream
		<< 'this.assert(';
		space;
		<< 'IsNull(';
		space;
		<< 'l_result';
		space;
		nextPut: $);
		nextPut: $);
		crlf
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> behaviorAccesses [
	^ behaviorAccesses
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> behaviorName [
	^ functionUnderTest name
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> behaviorParent [
	^ functionUnderTest parentType name
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> behaviorReturnValue [
	^ behaviorReturnValue
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> behaviorReturnValue: anObject [
	behaviorReturnValue := anObject
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> functionUnderTest [
	^ functionUnderTest
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> functionUnderTest: anObject [
	functionUnderTest := anObject
]

{ #category : #initialization }
PWBAbstractParametersUnitAssertion >> initialize [
	behaviorAccesses := OrderedCollection new
]

{ #category : #api }
PWBAbstractParametersUnitAssertion >> printAccesInitializationOn: aStream [
	behaviorAccesses
		do: [ :acc | 
			aStream
				<< 'l';
				<< acc pwb_object;
				nextPut: $.;
				<< (acc variableName copyReplaceAll: 'this.' with: '');
				space;
				nextPut: $=;
				space;
				<<
					(PWBTypeValueSolver
						printValue: acc beforeValue
						ofType: acc variableTypeName);
				crlf ]
]

{ #category : #printing }
PWBAbstractParametersUnitAssertion >> printAccessAssertionOn: stream [
	behaviorAccesses
		do: [ :acc | 
			stream
				<< 'this.assert(';
				<< acc afterValue;
				nextPut: $=;
				<< 'l';
				<< acc pwb_object;
				nextPut: $.;
				<< (acc variableName copyReplaceAll: 'this.' with: '');
				nextPut: $);
				crlf ]
]

{ #category : #printing }
PWBAbstractParametersUnitAssertion >> printReturnAssertionOn: stream [
	behaviorReturnValue mrlValue
		ifNil: [ self assertNilOn: stream ]
		ifNotNil: [ stream
				<< 'this.assert(';
				space;
				<<
					(PWBTypeValueSolver
						printValue: behaviorReturnValue mrlValue
						ofType: functionUnderTest returnType name);
				space;
				<< '=';
				space;
				<< 'l_result';
				nextPut: $);
				crlf ].
	^ stream
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> pwbParameters [
	^ pwbParameters sortAscending: #startPosition
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> pwbParameters: anObject [
	pwbParameters := anObject
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> timestamp [
	^ timestamp
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> timestamp: aString [
	timestamp := aString
]
