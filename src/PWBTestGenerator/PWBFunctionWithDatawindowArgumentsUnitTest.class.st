Class {
	#name : #PWBFunctionWithDatawindowArgumentsUnitTest,
	#superclass : #PWBUnitTest,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #visiting }
PWBFunctionWithDatawindowArgumentsUnitTest class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isNotEmpty
		and: [ aFamixPWBFunction parameters anySatisfy: #isPWBDataWindow ]
]

{ #category : #'instance creation' }
PWBFunctionWithDatawindowArgumentsUnitTest >> newPWBTestWindowOn: aStream [
	aStream
		<< 'w_PBUnitTest_window lw_PBUnitTest_window';
		crlf;
		<< 'open(lw_PBUnitTest_window)';
		crlf;
		<< 'lw_PBUnitTest_window.hide()';
		crlf
]

{ #category : #printing }
PWBFunctionWithDatawindowArgumentsUnitTest >> printPWBScriptOn: stream [
	super printPWBScriptOn: stream.
	self newPWBTestWindowOn: stream.
	behaviorUnderTest returnType
		ifNotNil: [ self printReturnValueDeclarationOn: stream ].
	self printParameterDeclarationOn: stream.
	self printAssertionsOn: stream.
	self endOn: stream.
	^ stream
]

{ #category : #printing }
PWBFunctionWithDatawindowArgumentsUnitTest >> printParameterDeclarationOn: stream [
	self behaviorUnderTest parameters
		do: [ :param | 
			param isPWBDataWindow
				ifFalse: [ stream
						<< param parameterType name;
						space;
						<< 'l';
						<< (param name copyFrom: 2 to: param name size);
						crlf ] ].
	^ stream
]
