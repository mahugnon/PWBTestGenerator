Class {
	#name : #PWBAbstractParametersUnitAssertion,
	#superclass : #Object,
	#instVars : [
		'behaviorReturnValue',
		'timestamp',
		'functionUnderTest',
		'pwbParameters'
	],
	#category : #'PWBTestGenerator-Assertions'
}

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
