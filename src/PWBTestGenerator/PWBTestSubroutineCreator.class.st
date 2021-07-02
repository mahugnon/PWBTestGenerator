Class {
	#name : #PWBTestSubroutineCreator,
	#superclass : #PWBTestBehaviorCreator,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #'as yet unclassified' }
PWBTestSubroutineCreator class >> accept: mrlBehavior [
	^ mrlBehavior isSubRoutine
]

{ #category : #'as yet unclassified' }
PWBTestSubroutineCreator >> behaviorInvocation: mrlBehavior on: stream [
	| localVar |
	localVar := 'l' , mrlBehavior pwb_object.
	stream
		<< localVar;
		nextPut: $..
	self behaviorWithParams: mrlBehavior on: stream
]
