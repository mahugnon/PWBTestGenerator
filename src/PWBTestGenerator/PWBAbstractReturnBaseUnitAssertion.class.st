Class {
	#name : #PWBAbstractReturnBaseUnitAssertion,
	#superclass : #PWBTestGeneratorTask,
	#instVars : [
		'behaviorReturnValue',
		'timestamp',
		'pwbParameters',
		'behaviorUnderTest'
	],
	#category : #'PWBTestGenerator-Task'
}

{ #category : #'as yet unclassified' }
PWBAbstractReturnBaseUnitAssertion class >> accept: aCollection [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBAbstractReturnBaseUnitAssertion class >> assertionFor: aCollection [
	^ self new pwbParameters: aCollection
]

{ #category : #adding }
PWBAbstractReturnBaseUnitAssertion >> addRows: dwName tag: aTag on: aStream dwParam: aDwParam [
	| pwbData paramValue |
	paramValue := aTag = 'before'
		ifTrue: [ aDwParam beforeValue mrlvalue ]
		ifFalse: [ aDwParam afterValue mrlvalue ].
	pwbData := CSVParser parseWithHeader: paramValue.
	pwbData ifEmpty: [ ^ aStream ].
	aStream
		<< dwName;
		<< '.insertRow(0)';
		crlf.
	pwbData anyOne
		keysAndValuesDo: [ :key :value | 
			value
				ifNotNil: [ aStream
						<< dwName;
						<< '.setItem(';
						<< dwName;
						<< '.rowcount(),';
						<< '"';
						<< key asString;
						<< '",';
						<< 'f_mrl_parse(';
						space;
						nextPut: $";
						<< value;
						nextPut: $";
						nextPut: $,;
						<< dwName;
						<< '.object.';
						<< key asString;
						<< '.colType';
						nextPut: $);
						nextPut: $);
						crlf ] ]
]

{ #category : #printing }
PWBAbstractReturnBaseUnitAssertion >> assertNilOn: stream [
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
PWBAbstractReturnBaseUnitAssertion >> behaviorReturnValue [
	^ behaviorReturnValue
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> behaviorReturnValue: anObject [
	behaviorReturnValue := anObject
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> behaviorUnderTest [
	^ behaviorUnderTest
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> behaviorUnderTest: anObject [
	behaviorUnderTest := anObject
]

{ #category : #testing }
PWBAbstractReturnBaseUnitAssertion >> isReturnBasedAssertion [
	^ true
]

{ #category : #printing }
PWBAbstractReturnBaseUnitAssertion >> printPWBScriptOn: stream [
	self printReturnAssertionOn: stream.
	^ stream
]

{ #category : #printing }
PWBAbstractReturnBaseUnitAssertion >> printReturnAssertionOn: stream [
	behaviorReturnValue mrlValue
		ifNil: [ self assertNilOn: stream ]
		ifNotNil: [ stream
				<< 'this.assert(';
				space;
				<<
					(PWBVariableInitializer
						printValue: behaviorReturnValue mrlValue
						ofType: behaviorUnderTest returnType name);
				space;
				<< '=';
				space;
				<< 'l_result';
				nextPut: $);
				crlf ].
	^ stream
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> priority [
	^ 50
]

{ #category : #'as yet unclassified' }
PWBAbstractReturnBaseUnitAssertion >> pwbParameters [
	^ pwbParameters sortAscending: #startPosition
]

{ #category : #'as yet unclassified' }
PWBAbstractReturnBaseUnitAssertion >> pwbParameters: anObject [
	pwbParameters := anObject
]
