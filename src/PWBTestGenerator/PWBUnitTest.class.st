Class {
	#name : #PWBUnitTest,
	#superclass : #Object,
	#instVars : [
		'name',
		'owner',
		'invocation',
		'receiver',
		'mrlBehavior',
		'behaviorUnderTest',
		'generationTasks'
	],
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #printing }
PWBUnitTest >> printPWBObjectCreationOn: aStream [
	^ PWBCreateTestObjectTask
		createAndInitialize: self mrlBehavior pwb_object
		on: aStream
]
