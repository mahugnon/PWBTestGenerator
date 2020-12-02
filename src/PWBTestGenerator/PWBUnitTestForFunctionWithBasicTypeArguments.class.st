Class {
	#name : #PWBUnitTestForFunctionWithBasicTypeArguments,
	#superclass : #PWBUnitTest,
	#category : #'PWBTestGenerator-PWBTestCase'
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
	functionUnderTest returnType
		ifNotNil: [ self printReturnValueDeclarationOn: stream ].
	self printParametersDeclarationOn: stream.
	self printAssersionsOn: stream.
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
