"
I am related to a PWBMethod. I have many steps:
- Parameters initialization
- Accesses initialization
- The method invocation
- Accesses assertions
- Retun assertions

"
Class {
	#name : #PWBTestMethod,
	#superclass : #Object,
	#instVars : [
		'invocation',
		'receiver',
		'mrlBehavior',
		'behaviorUnderTest',
		'steps'
	],
	#category : #'PWBTestGenerator-PWBTestSuite'
}

{ #category : #visiting }
PWBTestMethod class >> accept: aFamixPWBInvocation [
	^ self subclassResponsibility
]

{ #category : #visiting }
PWBTestMethod class >> acceptFunction: aFamixPWBFunction [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBTestMethod class >> unitTestForFunction: aFamixPWBFunction [
	^ (self allSubclasses
		detect: [ :sub | sub acceptFunction: aFamixPWBFunction ]) new
		behaviorUnderTest: aFamixPWBFunction
]

{ #category : #accessing }
PWBTestMethod >> beginOn: stream [
	^ stream
		<< 'event';
		space;
		<< self name;
		<< '();';
		crlf;
		crlf
]

{ #category : #accessing }
PWBTestMethod >> behaviorUnderTest [
	^ behaviorUnderTest
]

{ #category : #accessing }
PWBTestMethod >> behaviorUnderTest: anObject [
	behaviorUnderTest := anObject
]

{ #category : #'as yet unclassified' }
PWBTestMethod >> createSteps [
	steps := self mrlBehavior createSteps
		sorted: [ :t1 :t2 | t1 shouldExecuteBefore: t2 ]
]

{ #category : #printing }
PWBTestMethod >> endOn: stream [
	stream
		<< 'end event';
		crlf
]

{ #category : #testing }
PWBTestMethod >> hasAssertions [
	^ self mrlBehavior hasAssertions
]

{ #category : #initialization }
PWBTestMethod >> initialize [
	steps := Set new
]

{ #category : #'as yet unclassified' }
PWBTestMethod >> loadMrlBehavior [
	mrlBehavior := (MrlBehavior
		loadWithMrlParameterAndMrlReturnValuesWhere: [ :function | 
			function behavior_name = behaviorUnderTest name
				AND: [ function pwb_object = behaviorUnderTest parentType name ] ])
		anyOne behaviorUnderTest: behaviorUnderTest
]

{ #category : #accessing }
PWBTestMethod >> mrlBehavior [
	mrlBehavior ifNil: [ self loadMrlBehavior ].
	^ mrlBehavior
]

{ #category : #accessing }
PWBTestMethod >> mrlBehavior: aCollection [ 
	mrlBehavior := aCollection
]

{ #category : #accessing }
PWBTestMethod >> name [
	^ 'test_' , behaviorUnderTest name
]

{ #category : #printing }
PWBTestMethod >> printPWBObjectCreationOn: aStream [
	^ PWBCreateTestObjectTask
		createAndInitialize: self mrlBehavior pwb_object
		on: aStream
]

{ #category : #printing }
PWBTestMethod >> printPWBScriptOn: stream [
	self createSteps.
	self beginOn: stream.
	self printPWBObjectCreationOn: stream.
	^ stream
]

{ #category : #printing }
PWBTestMethod >> printReturnValueDeclarationOn: stream [
	^ stream
		<< behaviorUnderTest returnType name;
		space;
		<< 'l_result';
		crlf
]

{ #category : #printing }
PWBTestMethod >> runStepsOn: stream [
	self beginOn: stream.
	steps do: [ :assert | assert printPWBScriptOn: stream ].
	self endOn: stream
]

{ #category : #accessing }
PWBTestMethod >> steps [
	^ steps
]
