Class {
	#name : #PWBBehaviorWithBasicTypeArgumentsTestMethod,
	#superclass : #PWBTestMethod,
	#category : #'PWBTestGenerator-PWBTestSuite'
}

{ #category : #visiting }
PWBBehaviorWithBasicTypeArgumentsTestMethod class >> accept: aFamixPWBInvocation [
	^ aFamixPWBInvocation candidates anyOne parameters
		allSatisfy: [ :param | param isBasic ]
]

{ #category : #visiting }
PWBBehaviorWithBasicTypeArgumentsTestMethod class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isNotEmpty
		and: [ aFamixPWBFunction parameters allSatisfy: #isBasic ]
]

{ #category : #printing }
PWBBehaviorWithBasicTypeArgumentsTestMethod >> printPWBScriptOn: stream [
	self flag: #todo.	"All step should be task with priority"
	self beginOn: stream.
	behaviorUnderTest returnType
		ifNotNil: [ self printReturnValueDeclarationOn: stream ].
	self printParametersDeclarationOn: stream.
	self runStepsOn: stream.
	self endOn: stream.
	^ stream
]

{ #category : #printing }
PWBBehaviorWithBasicTypeArgumentsTestMethod >> printParametersDeclarationOn: stream [
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
