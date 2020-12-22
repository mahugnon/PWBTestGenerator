Class {
	#name : #PWBTestCaseInitializer,
	#superclass : #PWBTestGeneratorTask,
	#instVars : [
		'behaviorAccesses',
		'pwbParameters'
	],
	#category : #'PWBTestGenerator-Task'
}

{ #category : #visiting }
PWBTestCaseInitializer class >> accept: aCollection [
	self subclassResponsibility
]

{ #category : #tests }
PWBTestCaseInitializer class >> params: aCollection1 accesses: aCollection2 [
	^ (self subclasses detect: [ :sub | sub accept: aCollection1 ]) new
		pwbParameters: aCollection1;
		behaviorAccesses: aCollection2
]

{ #category : #adding }
PWBTestCaseInitializer >> addRows: dwName tag: aTag on: aStream dwParam: aDwParam [
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

{ #category : #api }
PWBTestCaseInitializer >> basicTypeAccess: acc initializationOn: aStream [
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
PWBTestCaseInitializer >> behaviorAccesses [
	^ behaviorAccesses
]

{ #category : #accessing }
PWBTestCaseInitializer >> behaviorAccesses: anObject [
	behaviorAccesses := anObject
]

{ #category : #api }
PWBTestCaseInitializer >> dataControlAccess: acc initializationOn: aStream [
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

{ #category : #initialization }
PWBTestCaseInitializer >> initialize [
	super initialize.
	pwbParameters := OrderedCollection new.
	behaviorAccesses := OrderedCollection new
]

{ #category : #testing }
PWBTestCaseInitializer >> isTestCaseInitializer [
	^ true
]

{ #category : #printing }
PWBTestCaseInitializer >> printAccesInitializationOn: aStream [
	behaviorAccesses
		do: [ :acc | 
			acc beforeValueDataobject
				ifNil: [ self basicTypeAccess: acc initializationOn: aStream ]
				ifNotNil: [ self dataControlAccess: acc initializationOn: aStream ] ]
]

{ #category : #printing }
PWBTestCaseInitializer >> printPWBScriptOn: stream [
	self printParametersInitializationOn: stream.
	self printAccesInitializationOn: stream
]

{ #category : #printing }
PWBTestCaseInitializer >> printParametersInitializationOn: stream [
	self pwbParameters
		do: [ :param | 
			param isPWBDataWindow
				ifFalse: [ PWBVariableInitializer printParameter: param on: stream ] ].
	^ stream
]

{ #category : #accessing }
PWBTestCaseInitializer >> priority [
	^ 10
]

{ #category : #accessing }
PWBTestCaseInitializer >> pwbParameters [
	^ pwbParameters sortAscending: #startPosition
]

{ #category : #accessing }
PWBTestCaseInitializer >> pwbParameters: anObject [
	pwbParameters := anObject
]
