Class {
	#name : #PWBUnitTestForFunctionWithOutArguments,
	#superclass : #PWBUnitTest,
	#category : #'PWBTestsGenerator-PWBTestUnitStrategy'
}

{ #category : #visiting }
PWBUnitTestForFunctionWithOutArguments class >> accept: aFamixPWBInvocation [
	^ aFamixPWBInvocation arguments isEmpty
]

{ #category : #visiting }
PWBUnitTestForFunctionWithOutArguments class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isEmpty
]
