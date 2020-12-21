Class {
	#name : #PWBAbstractBehaviorInvocation,
	#superclass : #Object,
	#instVars : [
		'behaviorReturnValue',
		'timestamp',
		'functionUnderTest',
		'pwbParameters',
		'behaviorAccesses'
	],
	#category : #'PWBTestGenerator-BehaviorInvocation'
}

{ #category : #adding }
PWBAbstractBehaviorInvocation >> addAccess: aMrlAccess [
	aMrlAccess mooseModel: functionUnderTest mooseModel.
	behaviorAccesses add: aMrlAccess
]

{ #category : #adding }
PWBAbstractBehaviorInvocation >> addRows: dwName tag: aTag on: aStream dwParam: aDwParam [
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
PWBAbstractBehaviorInvocation >> assertNilOn: stream [
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
PWBAbstractBehaviorInvocation >> basicTypeAccess: aMrlInstanceVariableAccess assertionOn: stream [
	^ stream
		<< 'this.assert(';
		<< aMrlInstanceVariableAccess afterValue mrlvalue;
		nextPut: $=;
		<< aMrlInstanceVariableAccess pwbTestVariableName;
		nextPut: $);
		crlf
]

{ #category : #api }
PWBAbstractBehaviorInvocation >> basicTypeAccess: acc initializationOn: aStream [
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
PWBAbstractBehaviorInvocation >> behaviorAccesses [
	^ behaviorAccesses
]

{ #category : #accessing }
PWBAbstractBehaviorInvocation >> behaviorAccesses: anObject [
	behaviorAccesses := anObject
]

{ #category : #accessing }
PWBAbstractBehaviorInvocation >> behaviorName [
	^ functionUnderTest name
]

{ #category : #accessing }
PWBAbstractBehaviorInvocation >> behaviorParent [
	^ functionUnderTest parentType name
]

{ #category : #accessing }
PWBAbstractBehaviorInvocation >> behaviorReturnValue [
	^ behaviorReturnValue
]

{ #category : #accessing }
PWBAbstractBehaviorInvocation >> behaviorReturnValue: anObject [
	behaviorReturnValue := anObject
]

{ #category : #printing }
PWBAbstractBehaviorInvocation >> dataControlAccess: acc assertionOn: stream [
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
PWBAbstractBehaviorInvocation >> dataControlAccess: acc initializationOn: aStream [
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
PWBAbstractBehaviorInvocation >> functionUnderTest [
	^ functionUnderTest
]

{ #category : #accessing }
PWBAbstractBehaviorInvocation >> functionUnderTest: anObject [
	functionUnderTest := anObject
]

{ #category : #initialization }
PWBAbstractBehaviorInvocation >> initialize [
	behaviorAccesses := OrderedCollection new
]

{ #category : #api }
PWBAbstractBehaviorInvocation >> printAccesInitializationOn: aStream [
	behaviorAccesses
		do: [ :acc | 
			acc beforeValueDataobject
				ifNil: [ self basicTypeAccess: acc initializationOn: aStream ]
				ifNotNil: [ self dataControlAccess: acc initializationOn: aStream ] ]
]

{ #category : #printing }
PWBAbstractBehaviorInvocation >> printAccessAssertionOn: stream [
	behaviorAccesses
		do: [ :acc | 
			acc beforeValueDataobject
				ifNil: [ self basicTypeAccess: acc assertionOn: stream ]
				ifNotNil: [ self dataControlAccess: acc assertionOn: stream ] ]
]

{ #category : #printing }
PWBAbstractBehaviorInvocation >> printFunctionInvocationScriptOn: stream [
	self subclassResponsibility
]

{ #category : #printing }
PWBAbstractBehaviorInvocation >> printPWBScriptOn: stream [
	self printParametersInitializationOn: stream.
	self printAccesInitializationOn: stream.
	self printFunctionInvocationScriptOn: stream.
	^ stream
]

{ #category : #printing }
PWBAbstractBehaviorInvocation >> printParametersInitializationOn: stream [
	self subclassResponsibility
]

{ #category : #printing }
PWBAbstractBehaviorInvocation >> printReturnAssertionOn: stream [
	behaviorReturnValue mrlValue
		ifNil: [ self assertNilOn: stream ]
		ifNotNil: [ stream
				<< 'this.assert(';
				space;
				<<
					(PWBVariableInitializer
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
PWBAbstractBehaviorInvocation >> pwbParameters [
	^ pwbParameters sortAscending: #startPosition
]

{ #category : #accessing }
PWBAbstractBehaviorInvocation >> pwbParameters: anObject [
	pwbParameters := anObject
]

{ #category : #'as yet unclassified' }
PWBAbstractBehaviorInvocation >> replaceLineBreakWithPwbLinebreak: aString [
	| pwbLineBreakString |
	pwbLineBreakString := ' ~r~n '.
	^ (aString copyReplaceAll: String cr with: pwbLineBreakString)
		copyReplaceAll: String lf
		with: pwbLineBreakString
]

{ #category : #accessing }
PWBAbstractBehaviorInvocation >> timestamp [
	^ timestamp
]

{ #category : #accessing }
PWBAbstractBehaviorInvocation >> timestamp: aString [
	timestamp := aString
]
