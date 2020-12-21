Class {
	#name : #PWBReturnBasedUnitAssertionDataWindowParam,
	#superclass : #PWBAbstractParametersUnitAssertion,
	#category : #'PWBTestGenerator-Assertions'
}

{ #category : #printing }
PWBReturnBasedUnitAssertionDataWindowParam >> printFunctionInvocationScriptOn: stream [
	| param localVar |
	self printParametersInitializationOn: stream.
	localVar := 'l' , self behaviorParent.
	stream
		<< 'l_result = ';
		<< localVar;
		nextPut: $.;
		<< self behaviorName;
		nextPut: $(.
	1 to: self pwbParameters size - 1 do: [ :iter | 
		param := self pwbParameters at: iter.
		param isPWBDataWindow
			ifTrue: [ stream
					<< 'lw_PBUnitTest_window.dw_before';
					space;
					nextPut: $, ]
			ifFalse: [ stream
					<< 'l';
					<< (param parameter_name copyFrom: 2 to: param parameter_name size);
					space;
					nextPut: $, ] ].
	param := self pwbParameters last.
	param isPWBDataWindow
		ifTrue: [ stream
				<< 'lw_PBUnitTest_window.dw_before';
				nextPut: $) ]
		ifFalse: [ stream
				<< 'l';
				<< (param parameter_name copyFrom: 2 to: param parameter_name size);
				space;
				nextPut: $) ].
	^ stream crlf
]

{ #category : #printing }
PWBReturnBasedUnitAssertionDataWindowParam >> printPWBScriptOn: stream [
	self printWindowDwSetUpOn: stream.
	super printPWBScriptOn: stream.
	^ stream
]

{ #category : #printing }
PWBReturnBasedUnitAssertionDataWindowParam >> printParametersInitializationOn: stream [
	self pwbParameters
		do: [ :param | 
			param isPWBDataWindow
				ifFalse: [ PWBVariableInitializer printParameter: param on: stream ] ].
	^ stream
]

{ #category : #printing }
PWBReturnBasedUnitAssertionDataWindowParam >> printWindowDwSetUpOn: stream [
	| dwParam |
	dwParam := self pwbParameters
		detect: [ :param | param isPWBDataWindow ].
	self setValues: stream tag: 'before' dwParam: dwParam.
	dwParam parameter_after_value
		ifNotNil: [ self setValues: stream tag: 'after' dwParam: dwParam ]
]

{ #category : #printing }
PWBReturnBasedUnitAssertionDataWindowParam >> setValues: stream tag: aTag dwParam: aDWParam [
	| dwName |
	dwName := 'lw_PBUnitTest_window.dw_' , aTag.
	stream
		<< dwName;
		<< '.dataobject = ';
		<< '"';
		<< (aDWParam parameter_dataobjectForTag: aTag);
		<< '"';
		crlf;
		<< dwName;
		<< '.setTrans(SQLCA)';
		crlf.
	self
		addRows: dwName
		tag: aTag
		on: stream
		dwParam: aDWParam
]
