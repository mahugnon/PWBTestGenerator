Class {
	#name : #PWBUnitTestForFunctionWithDatawindowArguments,
	#superclass : #PWBUnitTest,
	#category : #'PWBTestsGenerator-PWBTestUnit'
}

{ #category : #visiting }
PWBUnitTestForFunctionWithDatawindowArguments class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isNotEmpty
		and: [ aFamixPWBFunction parameters anySatisfy: #isPWBDataWindow ]
]

{ #category : #'instance creation' }
PWBUnitTestForFunctionWithDatawindowArguments >> newPWBTestWindowOn: aStream [
	aStream
		<< 'w_maryline_test_window lw_maryline_test_window';
		crlf;
		<< 'open(lw_maryline_test_window)';
		crlf
]

{ #category : #printing }
PWBUnitTestForFunctionWithDatawindowArguments >> printPWBScriptOn: stream [
	"self loadTestData."

	self createAssertionsFromData.
	self beginOn: stream.
	"self printAccessSetUpOn: stream."
	self printPWBObjectCreationOn: stream.
	self newPWBTestWindowOn: stream.
	self printReturnValueDeclarationOn: stream.
	self printParameterDeclarationOn: stream.
	self assertions
		do: [ :assert | 
			self printInstanceVariableAccessAt: assert timestamp on: stream.
			assert printPWBScriptOn: stream ].
	self endOn: stream.
	^ stream
]

{ #category : #printing }
PWBUnitTestForFunctionWithDatawindowArguments >> printParameterDeclarationOn: stream [
	self functionUnderTest parameters
		do: [ :param | 
			param isPWBDataWindow
				ifFalse: [ stream
						<< param parameterType name;
						space;
						<< param name;
						crlf ] ].
	^ stream
]
