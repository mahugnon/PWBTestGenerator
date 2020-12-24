Class {
	#name : #PWBSubRoutineInvocation,
	#superclass : #PWBBehaviorInvocation,
	#category : #'PWBTestGenerator-Task'
}

{ #category : #visiting }
PWBSubRoutineInvocation class >> accept: aFamixPWBBehavior [
	^ aFamixPWBBehavior isSubRoutine
]

{ #category : #printing }
PWBSubRoutineInvocation >> printPWBScriptOn: stream [
	| localVar |
	localVar := 'l' , self behaviorParent.
	stream
		<< localVar;
		nextPut: $..
	self behaviorWithParamsOn: stream
]
