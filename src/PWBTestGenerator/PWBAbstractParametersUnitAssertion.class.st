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
PWBAbstractParametersUnitAssertion >> printPWBDeclarationScript [
	| localVar param |
	self halt.
	localVar := 'l_' , self behaviorParent.
	^ String
		streamContents: [ :stream | 
			stream
				<< 'l_result = ';
				<< localVar;
				nextPut: $.;
				<< self behaviorName;
				nextPut: $(.
			1 to: self pwbParameters size - 1 do: [ :iter | 
				param := self pwbParameters at: iter.
				stream
					<<
						(PWBTypeValueSolver
							printParameter: param parameter_before_value
							on: param parameterType name);
					space;
					nextPut: $, ].
			param := self pwbParameters last.
			stream
				<<
					(PWBTypeValueSolver
						printParameter: param parameter_before_value
						on: param parameterType name);
				space;
				nextPut: $);
				crlf;
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
				crlf ]
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
