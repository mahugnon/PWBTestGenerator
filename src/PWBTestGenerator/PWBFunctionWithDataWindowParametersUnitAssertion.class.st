Class {
	#name : #PWBFunctionWithDataWindowParametersUnitAssertion,
	#superclass : #PWBAbstractParametersUnitAssertion,
	#category : #'PWBTestGenerator-Assertions'
}

{ #category : #printing }
PWBFunctionWithDataWindowParametersUnitAssertion >> printFunctionInvocationScriptOn: stream [
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
					<< param parameter_name;
					space;
					nextPut: $, ] ].
	param := self pwbParameters last.
	param isPWBDataWindow
		ifTrue: [ stream
				<< 'lw_PBUnitTest_window.dw_before';
				nextPut: $) ]
		ifFalse: [ stream
				<< param parameter_name;
				space;
				nextPut: $) ].
	^ stream
]

{ #category : #printing }
PWBFunctionWithDataWindowParametersUnitAssertion >> printPWBScriptOn: stream [
	self printWindowDwSetUpOn: stream.
	super printPWBScriptOn: stream.
	^ stream
]

{ #category : #printing }
PWBFunctionWithDataWindowParametersUnitAssertion >> printParameterInitializationOn: stream [
	self pwbParameters
		do: [ :param | 
			param isPWBDataWindow
				ifFalse: [ PWBTypeValueSolver printParameter: param on: stream ] ].
	^ stream
]

{ #category : #printing }
PWBFunctionWithDataWindowParametersUnitAssertion >> printParametersInitializationOn: stream [
	self pwbParameters
		do: [ :param | 
			param isPWBDataWindow
				ifFalse: [ PWBTypeValueSolver printParameter: param on: stream ] ].
	^ stream
]

{ #category : #printing }
PWBFunctionWithDataWindowParametersUnitAssertion >> printWindowDwSetUpOn: stream [
	| dwParam |
	dwParam := self pwbParameters
		detect: [ :param | param isPWBDataWindow ].
	self setValues: stream tag: 'before' dwParam: dwParam.
	dwParam parameter_after_value
		ifNotNil: [ self setValues: stream tag: 'after' dwParam: dwParam ]
]

{ #category : #printing }
PWBFunctionWithDataWindowParametersUnitAssertion >> setValues: stream tag: aTag dwParam: aDWParam [
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
