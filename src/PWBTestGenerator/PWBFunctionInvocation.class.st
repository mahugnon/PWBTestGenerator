Class {
	#name : #PWBFunctionInvocation,
	#superclass : #PWBBehaviorInvocation,
	#category : #'PWBTestGenerator-Task'
}

{ #category : #visiting }
PWBFunctionInvocation class >> accept: aFamixPWBBehavior [
	^ aFamixPWBBehavior isFunction
]

{ #category : #printing }
PWBFunctionInvocation >> printPWBScriptOn: stream [
	| localVar |
	localVar := 'l' , self behaviorParent.
	stream << 'l_result = '.
	stream
		<< localVar;
		nextPut: $..
	self behaviorWithParamsOn: stream.
	^ stream
]
