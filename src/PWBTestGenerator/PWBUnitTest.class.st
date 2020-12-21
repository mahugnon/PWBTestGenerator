Class {
	#name : #PWBUnitTest,
	#superclass : #Object,
	#instVars : [
		'functionUnderTest',
		'name',
		'assertions',
		'owner',
		'invocation',
		'receiver',
		'testsData'
	],
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #visiting }
PWBUnitTest class >> accept: aFamixPWBInvocation [
	^ self subclassResponsibility
]

{ #category : #visiting }
PWBUnitTest class >> acceptFunction: aFamixPWBFunction [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBUnitTest class >> unitTestForFunction: aFamixPWBFunction [
	^ (self allSubclasses
		detect: [ :sub | sub acceptFunction: aFamixPWBFunction ]) new
		functionUnderTest: aFamixPWBFunction
]

{ #category : #adding }
PWBUnitTest >> addAssertion: aMrlPWBUnitTestAssertion [
	self assertions
		detect: [ :assertion | assertion = aMrlPWBUnitTestAssertion ]
		ifNone: [ assertions add: aMrlPWBUnitTestAssertion ]
]

{ #category : #accessing }
PWBUnitTest >> assertions [
	^ assertions
]

{ #category : #accessing }
PWBUnitTest >> beginOn: stream [
	^ stream
		<< 'event';
		space;
		<< self name;
		<< '();';
		crlf;
		crlf
]

{ #category : #'as yet unclassified' }
PWBUnitTest >> createTestGenerationTask [
	assertions addAll: self testsData createTestGenerationTask
]

{ #category : #accessing }
PWBUnitTest >> endOn: stream [
	^ stream
		<< 'return;';
		crlf;
		<< 'end event';
		crlf;
		crlf
]

{ #category : #accessing }
PWBUnitTest >> functionUnderTest [
	^ functionUnderTest
]

{ #category : #accessing }
PWBUnitTest >> functionUnderTest: anObject [
	functionUnderTest := anObject
]

{ #category : #initialization }
PWBUnitTest >> initialize [
	assertions := Set new
]

{ #category : #accessing }
PWBUnitTest >> invocation [
	^ invocation
]

{ #category : #accessing }
PWBUnitTest >> invocation: anObject [
	invocation := anObject.
	self setUp

]

{ #category : #'as yet unclassified' }
PWBUnitTest >> loadTestData [
	testsData := (MrlBehavior
		loadWithMrlParameterAndMrlReturnValuesWhere: [ :function | 
			function behavior_name = functionUnderTest name
				AND: [ function pwb_object = functionUnderTest parentType name ] ])
		anyOne behaviorUnderTest: functionUnderTest
]

{ #category : #accessing }
PWBUnitTest >> name [
	name ifNil: [ name := 'test_' , functionUnderTest name ].
	^ name
]

{ #category : #accessing }
PWBUnitTest >> name: aString [ 
	name := aString
]

{ #category : #accessing }
PWBUnitTest >> owner [
	^ owner
]

{ #category : #accessing }
PWBUnitTest >> owner: anObject [
	owner := anObject.
	owner addType: self
]

{ #category : #printing }
PWBUnitTest >> printAssertionsOn: stream [
	assertions do: [ :assert | assert printPWBScriptOn: stream ]
]

{ #category : #printing }
PWBUnitTest >> printPWBObjectCreationOn: aStream [
	^ PWBTestObjectCreator
		createAndInitialize: self testsData pwb_object
		on: aStream
]

{ #category : #printing }
PWBUnitTest >> printPWBScriptOn: stream [
	self beginOn: stream.
	assertions
		do: [ :assert | assert printPWBScriptOn: stream ].
	self endOn: stream.
	^ stream
]

{ #category : #printing }
PWBUnitTest >> printReturnValueDeclarationOn: stream [
	^ stream
		<< functionUnderTest returnType name;
		space;
		<< 'l_result';
		crlf
]

{ #category : #accessing }
PWBUnitTest >> testsData [
	testsData ifNil: [ self loadTestData ].
	^ testsData
]

{ #category : #accessing }
PWBUnitTest >> testsData: aCollection [ 
	testsData := aCollection
]
