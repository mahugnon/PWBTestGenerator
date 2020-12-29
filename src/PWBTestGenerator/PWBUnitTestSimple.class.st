Class {
	#name : #PWBUnitTestSimple,
	#superclass : #Object,
	#instVars : [
		'mrlBehavior'
	],
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #visiting }
PWBUnitTestSimple class >> accept: aFamixPWBInvocation [
	^ self subclassResponsibility
]

{ #category : #visiting }
PWBUnitTestSimple class >> acceptFunction: aFamixPWBFunction [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBUnitTestSimple class >> unitTestForFunction: aFamixPWBFunction [
	^ (self allSubclasses
		detect: [ :sub | sub acceptFunction: aFamixPWBFunction ]) new
		behaviorUnderTest: aFamixPWBFunction
]

{ #category : #printing }
PWBUnitTestSimple >> behaviorInvocationTimestamp: timestamp on: stream [
	PWBTestBehaviorCreator behaviorInvocation: mrlBehavior on: stream
]

{ #category : #printing }
PWBUnitTestSimple >> headerEventOn: stream [
	^ stream
		<< 'event';
		space;
		<< 'test_';
		<< mrlBehavior behavior_name;
		<< '();';
		crlf;
		crlf
]

{ #category : #printing }
PWBUnitTestSimple >> instanceVariableAssertTimestamp: timestamp on: stream [
	mrlBehavior instanceVariableAccesses
		do: [ :acc | 
			acc timestamp = timestamp
				ifTrue: [ PWBTestInstanceVariableAssertCreator access: acc on: stream ] ]
]

{ #category : #printing }
PWBUnitTestSimple >> instanceVariableInitializationTimestamp: timestamp on: stream [
	mrlBehavior instanceVariableAccesses
		do: [ :acc | 
			acc timestamp = timestamp
				ifTrue: [ PWBTestInstanceVariableCreator access: acc on: stream ] ]
]

{ #category : #printing }
PWBUnitTestSimple >> ownerObjectOn: stream [
	PWBTestObjectCreator
		objectNamed: mrlBehavior pwb_object
		on: stream
]

{ #category : #printing }
PWBUnitTestSimple >> parameterAssertTimestamp: timestamp on: stream [
self flag: #todo
]

{ #category : #printing }
PWBUnitTestSimple >> parameterDeclarationOn: stream [
	mrlBehavior parameters
		do: [ :param | 
			param isPWBDataWindow
				ifTrue:
					[ 
					"In protect we have only one datawindow parameter"
					
					PWBTestObjectCreator objectNamed: 'w_PBUnitTest_window' on: stream ]
				ifFalse: [ stream
						<< param parameterType name;
						space;
						<< 'l';
						<< (param name copyFrom: 2 to: param name size);
						crlf ] ]
]

{ #category : #printing }
PWBUnitTestSimple >> parameterInitializationTimestamp: timestamp on: stream [
	mrlBehavior mrlParameters
		do: [ :param | 
			param timestamp = timestamp
				ifTrue: [ PWBTestParameterCreator param: param on: stream ] ]
]

{ #category : #printing }
PWBUnitTestSimple >> printPWBScriptOn: stream [
	self headerEventOn: stream.
	self ownerObjectOn: stream.
	self parameterDeclarationOn: stream.
	mrlBehavior timestamps
		do: [ :timestamp | self printPWBScriptTimestamp: timestamp on: stream ].
	^ stream
]

{ #category : #printing }
PWBUnitTestSimple >> printPWBScriptTimestamp: timestamp on: stream [
	self instanceVariableInitializationTimestamp: timestamp on: stream.
	self parameterInitializationTimestamp: timestamp on: stream.
	self behaviorInvocationTimestamp: timestamp on: stream.
	self parameterAssertTimestamp: timestamp on: stream.
	self instanceVariableAssertTimestamp: timestamp on: stream.
	self returnAssertTimestamp: timestamp on: stream
]

{ #category : #printing }
PWBUnitTestSimple >> returnAssertTimestamp: timestamp on: stream [
	self flag: #todo
]
