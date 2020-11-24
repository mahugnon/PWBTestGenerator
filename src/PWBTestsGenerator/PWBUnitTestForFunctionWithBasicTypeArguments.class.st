Class {
	#name : #PWBUnitTestForFunctionWithBasicTypeArguments,
	#superclass : #PWBUnitTest,
	#category : #'PWBTestsGenerator-PWBTestUnit'
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
PWBUnitTestForFunctionWithBasicTypeArguments >> printPWBScriptOn: stream [
	self createAssertionsFromData.
	self beginOn: stream.
	self printPWBObjectCreationOn: stream.
	self printReturnValueDeclarationOn: stream.
	self printParametersDeclarationOn: stream.
	assertions
		do:
			[ :assert | "self printInstanceVariableAccessAt: assert timestamp on: stream." assert printPWBScriptOn: stream ].
	self endOn: stream.
	^ stream
]

{ #category : #printing }
PWBUnitTestForFunctionWithBasicTypeArguments >> printParametersDeclarationOn: stream [
	self functionUnderTest parameters
		do: [ :param | 
			stream
				<< param parameterType name;
				space;
				<< 'l';
				<< (param name copyFrom: 2 to: param name size);
				crlf ].
	^ stream
]
