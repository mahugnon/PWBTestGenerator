Class {
	#name : #PWBTestEventCreator,
	#superclass : #PWBTestBehaviorCreator,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #'as yet unclassified' }
PWBTestEventCreator class >> accept: mrlBehavior [
	^ mrlBehavior isEvent
]

{ #category : #'as yet unclassified' }
PWBTestEventCreator >> behaviorInvocation: behavior on: stream [
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
