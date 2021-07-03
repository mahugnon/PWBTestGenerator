Class {
	#name : #PWBSmokeTestSubroutineCreator,
	#superclass : #PWBSmokeTestBehaviorCreator,
	#category : #'PWBTestGenerator-SmokeTests'
}

{ #category : #'as yet unclassified' }
PWBSmokeTestSubroutineCreator class >> accept: mrlBehavior [
	^ mrlBehavior isSubRoutine
]

{ #category : #'as yet unclassified' }
PWBSmokeTestSubroutineCreator >> behaviorInvocation: behavior on: stream [
	| localVar |
	localVar := 'l' , behavior parentType name.
	stream
		<< localVar;
		nextPut: $..
	self behaviorWithParams: behavior on: stream
]
