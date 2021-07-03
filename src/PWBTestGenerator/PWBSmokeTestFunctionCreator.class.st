Class {
	#name : #PWBSmokeTestFunctionCreator,
	#superclass : #PWBSmokeTestBehaviorCreator,
	#category : #'PWBTestGenerator-SmokeTests'
}

{ #category : #'as yet unclassified' }
PWBSmokeTestFunctionCreator class >> accept: mrlBehavior [
	^ mrlBehavior isFunction
]

{ #category : #'as yet unclassified' }
PWBSmokeTestFunctionCreator >> behaviorInvocation: mrlBehavior on: stream [
	| localVar |
	localVar := 'l' , mrlBehavior pwb_object.
	stream << 'l_result = '.
	stream
		<< localVar;
		nextPut: $..
	self behaviorWithParams: mrlBehavior on: stream.
	^ stream
]
