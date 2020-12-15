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

{ #category : #adding }
PWBAbstractParametersUnitAssertion >> addRows: dwName tag: aTag on: aStream dwParam: aDwParam [
	| pwbData paramValue |
	paramValue := aTag = 'before'
		ifTrue: [ aDwParam beforeValue ]
		ifFalse: [ aDwParam afterValue ].
	pwbData := (CSVParser parseWithHeader: paramValue) anyOne.
	pwbData
		keysAndValuesDo: [ :key :value | 
			aStream
				<< dwName;
				<< '.insertRow(0)';
				crlf.
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

{ #category : #'as yet unclassified' }
PWBAbstractParametersUnitAssertion >> basicTypeAccess: aMrlInstanceVariableAccess assertionOn: stream [
	^ stream
		<< 'this.assert(';
		<< aMrlInstanceVariableAccess afterValue;
		nextPut: $=;
		<< aMrlInstanceVariableAccess pwbTestVariableName;
		nextPut: $);
		crlf
]

{ #category : #api }
PWBAbstractParametersUnitAssertion >> basicTypeAccess: acc initializationOn: aStream [
	^ aStream
		<< acc pwbTestVariableName;
		space;
		nextPut: $=;
		space;
		<<
			(PWBTypeValueSolver
				printValue: acc beforeValue
				ofType: acc variableTypeName);
		crlf
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> behaviorAccesses [
	^ behaviorAccesses
]

{ #category : #accessing }
PWBAbstractParametersUnitAssertion >> behaviorAccesses: anObject [
	behaviorAccesses := anObject
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

{ #category : #printing }
PWBAbstractParametersUnitAssertion >> dataControlAccess: acc assertionOn: stream [
	stream
		<< 'this.assert(';
		<< acc pwbTestVariableName;
		<< '.dataobject = ';
		<< acc afterValueDataobject;
		nextPut: $);
		crlf.
	stream
		<< 'this.assert(f_get_datacontrol_content(';
		<< acc pwbTestVariableName;
		<< ') = "';
		<< acc afterValue mrlValue;
		<< '")';
		crlf.
	^ stream
]

{ #category : #api }
PWBAbstractParametersUnitAssertion >> dataControlAccess: acc initializationOn: aStream [
	aStream
		<< acc pwbTestVariableName;
		<< '.reset()';
		crlf;
		<< acc pwbTestVariableName;
		<< '.dataobject = "';
		<< acc beforeValueDataobject;
		nextPut: $";
		crlf.
	self
		addRows: acc pwbTestVariableName
		tag: 'before'
		on: aStream
		dwParam: acc variable.
	^ aStream
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
			acc beforeValueDataobject
				ifNil: [ self basicTypeAccess: acc initializationOn: aStream ]
				ifNotNil: [ self dataControlAccess: acc initializationOn: aStream ].
			aStream
				<< acc pwbTestVariableName;
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
			acc beforeValueDataobject
				ifNil: [ self basicTypeAccess: acc assertionOn: stream ]
				ifNotNil: [ self dataControlAccess: acc assertionOn: stream ] ]
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
