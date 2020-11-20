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
	#category : #'PWBTestsGenerator-PWBTestUnitStrategy'
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
	aFamixPWBFunction setParameters.
	^ (self subclasses
		detect: [ :sub | sub acceptFunction: aFamixPWBFunction ]) new
		functionUnderTest: aFamixPWBFunction
]

{ #category : #'as yet unclassified' }
PWBUnitTest class >> unitTestsForFunction: aFamixPWBFunction [
	aFamixPWBFunction setParameters.
	^ (self subclasses
		select: [ :sub | sub acceptFunction: aFamixPWBFunction ])
		do: [ :sub | sub new functionUnderTest: aFamixPWBFunction ]
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
PWBUnitTest >> begin [
	^ String
		streamContents: [ :stream | 
			stream
				<< 'event';
				space;
				<< self name;
				<< '();';
				crlf ]
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
PWBUnitTest >> createAssertionsFromData [
	assertions addAll: self testsData createAssertionsFromData
]

{ #category : #accessing }
PWBUnitTest >> end [
	^ String
		streamContents: [ :stream | 
			stream
				<< 'return;';
				crlf;
				<< 'end event' ]
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

{ #category : #api }
PWBUnitTest >> printInstanceVariableAccessAt: aString on: aStream [
	| accesses |
	accesses := self testsData getInstanceVariableAccess: aString.
	accesses
		do: [ :access | 
			| varname |
			varname := 'l_' , self testsData pwb_object , '.' , access variable.
			access isBasic
				ifTrue: [ aStream
						<< varname;
						space;
						nextPut: $=;
						space;
						<<
							(PWBTypeValueResolver
								resolveValue: access beforeValue
								withType: access variableTypeName);
						crlf ]
				ifFalse: [ aStream
						<<
							(DatawindowValueResolver new
								dw_fullName: varname;
								resolve: access beforeValue) ] ].
	aStream crlf.
	^ aStream
]

{ #category : #printing }
PWBUnitTest >> printPWBDeclarationScript [
	^ String
		streamContents: [ :stream | 
			stream
				<< self begin;
				crlf.
			assertions
				do: [ :assert | assert printPWBDeclarationScriptOn: stream ].
			stream
				<< self end;
				crlf ]
]

{ #category : #printing }
PWBUnitTest >> printPWBDeclarationScriptOn: stream [
	stream
		<< self begin;
		crlf.
	assertions
		do: [ :assert | assert printPWBDeclarationScriptOn: stream ].
	stream
		<< self end;
		crlf.
	^ stream
]

{ #category : #printing }
PWBUnitTest >> printPWBObjectCreationOn: aStream [
	| localVar |
	"self loadTestData."
	localVar := 'l_' , self testsData pwb_object.
	^ aStream
		<< self testsData pwb_object;
		space;
		<< localVar;
		crlf;
		<< localVar;
		space;
		<< '=';
		space;
		<< 'create';
		space;
		<< self testsData pwb_object;
		crlf
]

{ #category : #printing }
PWBUnitTest >> printReturnValueDeclarationOn: stream [
	^ stream
		<< testsData returnType;
		space;
		<< 'l_result';
		crlf
]

{ #category : #accessing }
PWBUnitTest >> testsData [
	testsData ifNil: [ self loadTestData ].
	^ testsData
]
