Class {
	#name : #PWBUnitTestForFunctionWithOutArguments,
	#superclass : #PWBUnitTest,
	#category : #'PWBTestGenerator-PWBTestUnit'
}

{ #category : #visiting }
PWBUnitTestForFunctionWithOutArguments class >> accept: aFamixPWBInvocation [
	^ aFamixPWBInvocation arguments isEmpty
]

{ #category : #visiting }
PWBUnitTestForFunctionWithOutArguments class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isEmpty
]

{ #category : #printing }
PWBUnitTestForFunctionWithOutArguments >> printPWBScriptOn: stream [
"self halt . Print Nothing for now"
]