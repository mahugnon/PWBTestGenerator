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
	aMrlAccess mooseModel: functionUnderTest mooseModel.
	behaviorAccesses add: aMrlAccess
]

{ #category : #adding }
PWBAbstractParametersUnitAssertion >> addRows: dwName tag: aTag on: aStream dwParam: aDwParam [
	| pwbData paramValue |
	paramValue := aTag = 'before'
		ifTrue: [ aDwParam beforeValue mrlvalue ]
		ifFalse: [ aDwParam afterValue mrlvalue ].
	pwbData := (CSVParser parseWithHeader: paramValue)
		ifNotEmpty: [ :data | data anyOne ].
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
		<< aMrlInstanceVariableAccess afterValue mrlvalue;
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
				printValue: acc beforeValue mrlvalue
				ofType: acc instance_variable_access_accessedTypeName);
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
		<< '.dataobject = "';
		<< acc afterValueDataobject;
		<< '")';
		crlf.
	1 halt.
	stream
		<< 'this.assert(f_get_datacontrol_content(';
		<< acc pwbTestVariableName;
		<< ') = "';
		<< (acc afterValue mrlvalue copyReplaceAll: Character cr with: '~r~n');
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
		dwParam: acc.
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
				ifNotNil: [ self dataControlAccess: acc initializationOn: aStream ] ]
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
PWBAbstractParametersUnitAssertion >> printFunctionInvocationScriptOn: stream [
	self subclassResponsibility
]

{ #category : #printing }
PWBAbstractParametersUnitAssertion >> printPWBScriptOn: stream [
	self printParametersInitializationOn: stream.
	self printAccesInitializationOn: stream.
	self printFunctionInvocationScriptOn: stream.
	self printAccessAssertionOn: stream.
	self printReturnAssertionOn: stream.
	^ stream
]

{ #category : #printing }
PWBAbstractParametersUnitAssertion >> printParametersInitializationOn: stream [
	self subclassResponsibility
]

{ #category : #printing }
PWBAbstractParametersUnitAssertion >> printReturnAssertionOn: stream [
	behaviorReturnValue mrlvalue
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
