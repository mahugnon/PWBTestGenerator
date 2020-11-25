Class {
	#name : #PWBAbstractParametersUnitAssertion,
	#superclass : #Object,
	#instVars : [
		'mrlParameters',
		'behaviorName',
		'behaviorParent',
		'behaviorReturnValue',
		'originalBehavior',
		'timestamp'
	],
	#category : #'PWBTestGenerator-Assertions'
}

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> behaviorName [
	^ behaviorName
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> behaviorName: anObject [
	behaviorName := anObject
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> behaviorParent [
	^ behaviorParent
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> behaviorParent: anObject [
	behaviorParent := anObject
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
PWBAbstractParametersUnitAssertion >> mrlParameters: anObject [
	mrlParameters := anObject
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> originalBehavior [
	^ originalBehavior
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> originalBehavior: anObject [
	originalBehavior := anObject
]

{ #category : #printing }
PWBAbstractParametersUnitAssertion >> printPWBDeclarationScript [
	| localVar param |
	localVar := 'l_' , behaviorParent.
	^ String
		streamContents: [ :stream | 
			stream
				<< 'l_result = ';
				<< localVar;
				nextPut: $.;
				<< behaviorName;
				nextPut: $(.
			1 to: self pwbParameters size - 1 do: [ :iter | 
				param := self pwbParameters at: iter.
				stream
					<<
						(PWBTypeValueSolver
							resolveValue: param parameter_before_value
							withType: param parameterType name);
					space;
					nextPut: $, ].
			param := self pwbParameters last.
			stream
				<<
					(PWBTypeValueSolver
						resolveValue: param parameter_before_value
						withType: param parameterType name);
				space;
				nextPut: $);
				crlf;
				<< 'this.assert(';
				space;
				<<
					(PWBTypeValueSolver
						resolveValue: behaviorReturnValue mrlValue
						withType: originalBehavior returnType name);
				space;
				<< '=';
				space;
				<< 'l_result';
				nextPut: $);
				crlf ]
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> pwbParameters [
	^ mrlParameters sortAscending: #startPosition
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> timestamp [
	^ timestamp
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> timestamp: aString [
	timestamp := aString
]
