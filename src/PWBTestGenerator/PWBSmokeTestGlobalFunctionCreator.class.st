Class {
	#name : #PWBSmokeTestGlobalFunctionCreator,
	#superclass : #PWBSmokeTestBehaviorCreator,
	#category : #'PWBTestGenerator-SmokeTests'
}

{ #category : #'as yet unclassified' }
PWBSmokeTestGlobalFunctionCreator class >> accept: mrlBehavior [
	^ mrlBehavior isGlobal
]

{ #category : #'as yet unclassified' }
PWBSmokeTestGlobalFunctionCreator >> behaviorInvocation: mrlBehavior on: stream [
	stream << 'l_result = '.
	self behaviorWithParams: mrlBehavior on: stream
]
