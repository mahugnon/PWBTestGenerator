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
	#category : #'PWBTestsGenerator-assertions'
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
PWBAbstractParametersUnitAssertion >> mrlParameters [
	^ mrlParameters sortAscending: #startPosition
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
			1 to: self mrlParameters size - 1 do: [ :iter | 
				param := self mrlParameters at: iter.
				stream
					<<
						(PWBTypeValueResolver
							resolveValue: param parameter_before_value
							withType: param parameterType name);
					space;
					nextPut: $, ].
			param := self mrlParameters last.
			stream
				<<
					(PWBTypeValueResolver
						resolveValue: param parameter_before_value
						withType: param parameterType name);
				space;
				nextPut: $);
				crlf;
				<< 'this.assert(';
				space;
				<<
					(PWBTypeValueResolver
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
PWBAbstractParametersUnitAssertion >> timestamp [
	^ timestamp
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> timestamp: aString [
	timestamp := aString
]
