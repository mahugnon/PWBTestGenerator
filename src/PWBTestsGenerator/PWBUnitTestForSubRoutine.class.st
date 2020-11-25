Class {
	#name : #PWBUnitTestForSubRoutine,
	#superclass : #PWBUnitTest,
	#category : #'PWBTestsGenerator-PWBTestUnit'
}

{ #category : #visiting }
PWBUnitTestForSubRoutine class >> accept: aFamixPWBInvocation [
	^ false
]

{ #category : #visiting }
PWBUnitTestForSubRoutine class >> acceptFunction: aFamixPWBFunction [
	^ false
]

{ #category : #printing }
PWBUnitTestForSubRoutine >> printPWBScriptOn: stream [
self halt.
]
