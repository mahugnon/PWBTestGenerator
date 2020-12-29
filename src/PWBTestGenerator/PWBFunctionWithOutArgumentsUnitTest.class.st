Class {
	#name : #PWBFunctionWithoutArgumentsUnitTest,
	#superclass : #PWBUnitTest,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #visiting }
PWBFunctionWithoutArgumentsUnitTest class >> accept: aFamixPWBInvocation [
	^ aFamixPWBInvocation arguments isEmpty
]

{ #category : #visiting }
PWBFunctionWithoutArgumentsUnitTest class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isEmpty
]

{ #category : #printing }
PWBFunctionWithoutArgumentsUnitTest >> printPWBScriptOn: stream [
	super printPWBScriptOn: stream.
	behaviorUnderTest returnType
		ifNotNil: [ self printReturnValueDeclarationOn: stream ].
	self executeGenerationTasks: stream.
	self endOn: stream.
	^ stream
]
