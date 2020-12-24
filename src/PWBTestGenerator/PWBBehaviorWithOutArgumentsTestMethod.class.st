Class {
	#name : #PWBBehaviorWithOutArgumentsTestMethod,
	#superclass : #PWBTestMethod,
	#category : #'PWBTestGenerator-PWBTestSuite'
}

{ #category : #visiting }
PWBBehaviorWithOutArgumentsTestMethod class >> accept: aFamixPWBInvocation [
	^ aFamixPWBInvocation arguments isEmpty
]

{ #category : #visiting }
PWBBehaviorWithOutArgumentsTestMethod class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isEmpty
]

{ #category : #printing }
PWBBehaviorWithOutArgumentsTestMethod >> printPWBScriptOn: stream [
	super printPWBScriptOn: stream.
	behaviorUnderTest returnType
		ifNotNil: [ self printReturnValueDeclarationOn: stream ].
	self runStepsOn: stream.
	self endOn: stream.
	^ stream
]
