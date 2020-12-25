Class {
	#name : #PWBBehaviorWithDatawindowArgumentsTestMethod,
	#superclass : #PWBTestMethod,
	#category : #'PWBTestGenerator-PWBTestSuite'
}

{ #category : #visiting }
PWBBehaviorWithDatawindowArgumentsTestMethod class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isNotEmpty
		and: [ aFamixPWBFunction parameters anySatisfy: #isPWBDataWindow ]
]

{ #category : #'instance creation' }
PWBBehaviorWithDatawindowArgumentsTestMethod >> newPWBTestWindowOn: aStream [
	aStream
		<< 'w_PBUnitTest_window lw_PBUnitTest_window';
		crlf;
		<< 'open(lw_PBUnitTest_window)';
		crlf;
		<< 'lw_PBUnitTest_window.hide()';
		crlf
]

{ #category : #printing }
PWBBehaviorWithDatawindowArgumentsTestMethod >> printPWBScriptOn: stream [
	self beginOn: stream.
	self newPWBTestWindowOn: stream.
	behaviorUnderTest returnType
		ifNotNil: [ self printReturnValueDeclarationOn: stream ].
	self printParameterDeclarationOn: stream.
	self runStepsOn: stream.
	self endOn: stream.
	^ stream
]

{ #category : #printing }
PWBBehaviorWithDatawindowArgumentsTestMethod >> printParameterDeclarationOn: stream [
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
