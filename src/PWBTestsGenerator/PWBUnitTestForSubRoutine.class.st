Class {
	#name : #PWBUnitTestForSubRoutine,
	#superclass : #PWBUnitTest,
	#category : #'PWBTestsGenerator-PWBTestUnitStrategy'
}

{ #category : #visiting }
PWBUnitTestForSubRoutine class >> accept: aFamixPWBInvocation [
	^ false
]

{ #category : #visiting }
PWBUnitTestForSubRoutine class >> acceptFunction: aFamixPWBFunction [
	^ false
]
