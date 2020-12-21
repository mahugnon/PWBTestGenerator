Class {
	#name : #PWBAbstractReturnBaseUnitAssertion,
	#superclass : #Object,
	#instVars : [
		'behaviorReturnValue',
		'timestamp',
		'pwbParameters',
		'behaviorAccesses',
		'behaviorUnderTest'
	],
	#category : #'PWBTestGenerator-Assertions'
}

{ #category : #'as yet unclassified' }
PWBAbstractReturnBaseUnitAssertion class >> accept: aCollection [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBAbstractReturnBaseUnitAssertion class >> assertionFor: aCollection [
	^ self subclasses detect: [ :sub | sub accept: aCollection ]
]

{ #category : #adding }
PWBAbstractReturnBaseUnitAssertion >> addAccess: aMrlAccess [
	aMrlAccess mooseModel: behaviorUnderTest mooseModel.
	behaviorAccesses add: aMrlAccess
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

{ #category : #'as yet unclassified' }
PWBAbstractReturnBaseUnitAssertion >> basicTypeAccess: aMrlInstanceVariableAccess assertionOn: stream [
	^ stream
		<< 'this.assert(';
		<< aMrlInstanceVariableAccess afterValue mrlvalue;
		nextPut: $=;
		<< aMrlInstanceVariableAccess pwbTestVariableName;
		nextPut: $);
		crlf
]

{ #category : #api }
PWBAbstractReturnBaseUnitAssertion >> basicTypeAccess: acc initializationOn: aStream [
	^ aStream
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

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> behaviorAccesses [
	^ behaviorAccesses
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> behaviorAccesses: anObject [
	behaviorAccesses := anObject
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> behaviorName [
	^ behaviorUnderTest name
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> behaviorParent [
	^ behaviorUnderTest parentType name
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> behaviorReturnValue [
	^ behaviorReturnValue
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> behaviorReturnValue: anObject [
	behaviorReturnValue := anObject
]

{ #category : #printing }
PWBAbstractReturnBaseUnitAssertion >> dataControlAccess: acc assertionOn: stream [
	stream
		<< 'this.assert(';
		<< acc pwbTestVariableName;
		<< '.dataobject = "';
		<< acc afterValueDataobject;
		<< '")';
		crlf.
	stream
		<< 'this.assert(f_get_datacontrol_content(';
		<< acc pwbTestVariableName;
		<< ') = "';
		<< (self replaceLineBreakWithPwbLinebreak: acc afterValue mrlvalue);
		<< '")';
		crlf.
	^ stream
]

{ #category : #api }
PWBAbstractReturnBaseUnitAssertion >> dataControlAccess: acc initializationOn: aStream [
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
PWBAbstractReturnBaseUnitAssertion >> functionUnderTest [
	^ behaviorUnderTest
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> functionUnderTest: anObject [
	behaviorUnderTest := anObject
]

{ #category : #initialization }
PWBAbstractReturnBaseUnitAssertion >> initialize [
	behaviorAccesses := OrderedCollection new
]

{ #category : #api }
PWBAbstractReturnBaseUnitAssertion >> printAccesInitializationOn: aStream [
	behaviorAccesses
		do: [ :acc | 
			acc beforeValueDataobject
				ifNil: [ self basicTypeAccess: acc initializationOn: aStream ]
				ifNotNil: [ self dataControlAccess: acc initializationOn: aStream ] ]
]

{ #category : #printing }
PWBAbstractReturnBaseUnitAssertion >> printAccessAssertionOn: stream [
	behaviorAccesses
		do: [ :acc | 
			acc beforeValueDataobject
				ifNil: [ self basicTypeAccess: acc assertionOn: stream ]
				ifNotNil: [ self dataControlAccess: acc assertionOn: stream ] ]
]

{ #category : #printing }
PWBAbstractReturnBaseUnitAssertion >> printFunctionInvocationScriptOn: stream [
	^ PWBBehaviorInvocation new
		behaviorUnderTest: behaviorUnderTest;
		pwbParameters: self pwbParameters;
		printPWBScriptOn: stream
]

{ #category : #printing }
PWBAbstractReturnBaseUnitAssertion >> printPWBScriptOn: stream [
	self printParametersInitializationOn: stream.
	self printAccesInitializationOn: stream.
	self printFunctionInvocationScriptOn: stream.
	self printAccessAssertionOn: stream.
	self printReturnAssertionOn: stream.
	^ stream
]

{ #category : #printing }
PWBAbstractReturnBaseUnitAssertion >> printParametersInitializationOn: stream [
	self subclassResponsibility
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
PWBAbstractReturnBaseUnitAssertion >> pwbParameters [
	^ pwbParameters sortAscending: #startPosition
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> pwbParameters: anObject [
	pwbParameters := anObject
]

{ #category : #'as yet unclassified' }
PWBAbstractReturnBaseUnitAssertion >> replaceLineBreakWithPwbLinebreak: aString [
	| pwbLineBreakString |
	pwbLineBreakString := ' ~r~n '.
	^ (aString copyReplaceAll: String cr with: pwbLineBreakString)
		copyReplaceAll: String lf
		with: pwbLineBreakString
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> timestamp [
	^ timestamp
]

{ #category : #accessing }
PWBAbstractReturnBaseUnitAssertion >> timestamp: aString [
	timestamp := aString
]
