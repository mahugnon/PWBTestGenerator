Class {
	#name : #PWBUnitTestForFunctionWithBasicTypeArguments,
	#superclass : #PWBUnitTest,
	#category : #'PWBTestsGenerator-PWBTestUnitStrategy'
}

{ #category : #visiting }
PWBUnitTestForFunctionWithBasicTypeArguments class >> accept: aFamixPWBInvocation [
	^ aFamixPWBInvocation candidates anyOne parameters
		allSatisfy: [ :param | param isBasic ]
]

{ #category : #visiting }
PWBUnitTestForFunctionWithBasicTypeArguments class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isNotEmpty
		and: [ aFamixPWBFunction parameters allSatisfy: #isBasic ]
]

{ #category : #printing }
PWBUnitTestForFunctionWithBasicTypeArguments >> printPWBDeclarationScriptOn: stream [
	self createAssertionsFromData.
	self beginOn: stream.
	self printPWBObjectCreationOn: stream.
	self printReturnValueDeclarationOn: stream.
	assertions
		do: [ :assert | 
			"self printInstanceVariableAccessAt: assert timestamp on: stream."
			assert printPWBDeclarationScriptOn: stream ].
	self endOn: stream.
	^ stream
]
