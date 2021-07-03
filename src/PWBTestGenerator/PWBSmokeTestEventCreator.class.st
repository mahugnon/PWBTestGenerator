Class {
	#name : #PWBSmokeTestEventCreator,
	#superclass : #PWBSmokeTestBehaviorCreator,
	#category : #'PWBTestGenerator-SmokeTests'
}

{ #category : #'as yet unclassified' }
PWBSmokeTestEventCreator class >> accept: mrlBehavior [
	^ mrlBehavior isEvent
]

{ #category : #'as yet unclassified' }
PWBSmokeTestEventCreator >> behaviorInvocation: behavior on: stream [
	| localVar |
	localVar := 'l' , behavior parentType name.
	stream
		<< localVar;
		<< '.triggerEvent("';
		<< behavior name;
		<< '")';
		crlf.
	^ stream
]
