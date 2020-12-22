Class {
	#name : #PWBFunctionWithBasicTypeArgumentsUnitTest,
	#superclass : #PWBUnitTest,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #visiting }
PWBFunctionWithBasicTypeArgumentsUnitTest class >> accept: aFamixPWBInvocation [
	^ aFamixPWBInvocation candidates anyOne parameters
		allSatisfy: [ :param | param isBasic ]
]

{ #category : #visiting }
PWBFunctionWithBasicTypeArgumentsUnitTest class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isNotEmpty
		and: [ aFamixPWBFunction parameters allSatisfy: #isBasic ]
]

{ #category : #printing }
PWBFunctionWithBasicTypeArgumentsUnitTest >> printPWBScriptOn: stream [
	super printPWBScriptOn: stream.
	behaviorUnderTest returnType
		ifNotNil: [ self printReturnValueDeclarationOn: stream ].
	self printParametersDeclarationOn: stream.
	self printAssertionsOn: stream.
	self endOn: stream.
	^ stream
]

{ #category : #printing }
PWBFunctionWithBasicTypeArgumentsUnitTest >> printParametersDeclarationOn: stream [
	self behaviorUnderTest parameters
		do: [ :param | 
			stream
				<< param parameterType name;
				space;
				<< 'l';
				<< (param name copyFrom: 2 to: param name size);
				crlf ].
	^ stream
]
