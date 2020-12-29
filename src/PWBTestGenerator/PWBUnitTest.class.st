Class {
	#name : #PWBUnitTest,
	#superclass : #Object,
	#instVars : [
		'name',
		'owner',
		'invocation',
		'mrlBehavior',
		'behaviorUnderTest',
		'generationTasks'
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
		behaviorUnderTest: aFamixPWBFunction
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

{ #category : #accessing }
PWBUnitTest >> behaviorUnderTest [
	^ behaviorUnderTest
]

{ #category : #accessing }
PWBUnitTest >> behaviorUnderTest: anObject [
	behaviorUnderTest := anObject
]

{ #category : #'as yet unclassified' }
PWBUnitTest >> createTestGenerationTask [
	generationTasks := self mrlBehavior createTestGenerationTask
		sorted: [ :t1 :t2 | t1 shouldExecuteBefore: t2 ]
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

{ #category : #printing }
PWBUnitTest >> executeGenerationTasks: stream [
	generationTasks do: [ :assert | assert printPWBScriptOn: stream ]
]

{ #category : #accessing }
PWBUnitTest >> generationTasks [
	^ generationTasks
]

{ #category : #testing }
PWBUnitTest >> hasAssertions [
	^ self mrlBehavior hasAssertions
]

{ #category : #initialization }
PWBUnitTest >> initialize [
	generationTasks := Set new
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
PWBUnitTest >> loadMrlBehavior [
	mrlBehavior := (MrlBehavior
		loadWithMrlParameterAndMrlReturnValuesWhere: [ :function | 
			function behavior_name = behaviorUnderTest name
				AND: [ function pwb_object = behaviorUnderTest parentType name ] ])
		anyOne behaviorUnderTest: behaviorUnderTest
]

{ #category : #accessing }
PWBUnitTest >> mrlBehavior [
	mrlBehavior ifNil: [ self loadMrlBehavior ].
	^ mrlBehavior
]

{ #category : #accessing }
PWBUnitTest >> mrlBehavior: aCollection [ 
	mrlBehavior := aCollection
]

{ #category : #accessing }
PWBUnitTest >> name [
	name ifNil: [ name := 'test_' , behaviorUnderTest name ].
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
PWBUnitTest >> printPWBObjectCreationOn: aStream [
	^ PWBTestObjectCreator
		objectNamed: self mrlBehavior pwb_object
		on: aStream
]

{ #category : #printing }
PWBUnitTest >> printPWBScriptOn: stream [
	self createTestGenerationTask.
	self beginOn: stream.
	self printPWBObjectCreationOn: stream.
	^ stream
]

{ #category : #printing }
PWBUnitTest >> printReturnValueDeclarationOn: stream [
	^ stream
		<< behaviorUnderTest returnType name;
		space;
		<< 'l_result';
		crlf
]
