Class {
	#name : #PWBTestGlobalFunctionCreator,
	#superclass : #PWBTestBehaviorCreator,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #'as yet unclassified' }
PWBTestGlobalFunctionCreator class >> accept: mrlBehavior [
	^ mrlBehavior isGlobal
]

{ #category : #'as yet unclassified' }
PWBTestGlobalFunctionCreator >> behaviorInvocation: mrlBehavior on: stream [
	stream << 'l_result = '.
	self behaviorWithParams: mrlBehavior on: stream
]
