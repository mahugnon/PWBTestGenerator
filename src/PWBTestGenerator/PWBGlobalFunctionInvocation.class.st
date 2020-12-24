Class {
	#name : #PWBGlobalFunctionInvocation,
	#superclass : #PWBBehaviorInvocation,
	#category : #'PWBTestGenerator-Task'
}

{ #category : #visiting }
PWBGlobalFunctionInvocation class >> accept: aFamixPWBBehavior [
	^ aFamixPWBBehavior isGlobal
]

{ #category : #printing }
PWBGlobalFunctionInvocation >> printPWBScriptOn: stream [
	stream << 'l_result = '.
	self behaviorWithParamsOn: stream
]
