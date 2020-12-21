Class {
	#name : #PWBFunctionWithOutArgumentsUnitTest,
	#superclass : #PWBUnitTest,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #visiting }
PWBFunctionWithOutArgumentsUnitTest class >> accept: aFamixPWBInvocation [
	^ aFamixPWBInvocation arguments isEmpty
]

{ #category : #visiting }
PWBFunctionWithOutArgumentsUnitTest class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isEmpty
]

{ #category : #printing }
PWBFunctionWithOutArgumentsUnitTest >> printPWBScriptOn: stream [
	self createTestGenerationTask.
	self beginOn: stream.
	self printPWBObjectCreationOn: stream.
	behaviorUnderTest returnType
		ifNotNil: [ self printReturnValueDeclarationOn: stream ].
	self printAssertionsOn: stream.
	self endOn: stream.
	^ stream
]
