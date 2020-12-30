Class {
	#name : #PWBTestFunctionCreator,
	#superclass : #PWBTestBehaviorCreator,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #'as yet unclassified' }
PWBTestFunctionCreator class >> accept: mrlBehavior [
	^ mrlBehavior behaviorUnderTest isFunction
]

{ #category : #'as yet unclassified' }
PWBTestFunctionCreator >> behaviorInvocation: mrlBehavior on: stream [
	| localVar |
	localVar := 'l' , mrlBehavior pwb_object.
	stream << 'l_result = '.
	stream
		<< localVar;
		nextPut: $..
	self behaviorWithParams: mrlBehavior on: stream.
	^ stream
]
