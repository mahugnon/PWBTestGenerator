Class {
	#name : #PWBFunctionWithDataWindowParametersUnitAssertion,
	#superclass : #PWBAbstractParametersUnitAssertion,
	#category : #'PWBTestGenerator-Assertions'
}

{ #category : #printing }
PWBFunctionWithDataWindowParametersUnitAssertion >> printFunctionInvocationScriptOn: stream [
	| param localVar |
	self printParameterInitializationOn: stream.
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
	self printFunctionInvocationScriptOn: stream.
	self printAccessAssertionOn: stream.
	self printReturnAssertionOn: stream.
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
PWBFunctionWithDataWindowParametersUnitAssertion >> printWindowDwSetUpOn: stream [
	^ stream
		<<
			(DatawindowValueSolver
				resolve: (self pwbParameters detect: [ :param | param isPWBDataWindow ]))
]
