Class {
	#name : #PWBFunctionWithDataWindowParametersUnitAssertion,
	#superclass : #PWBAbstractParametersUnitAssertion,
	#category : #'PWBTestGenerator-Assertions'
}

{ #category : #printing }
PWBFunctionWithDataWindowParametersUnitAssertion >> printFunctionInvocationScriptOn: stream [
	| param localVar |
	self printParameterInitializationOn: stream.
	localVar := 'l' , behaviorParent.
	stream
		<< 'l_result = ';
		<< localVar;
		nextPut: $.;
		<< behaviorName;
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
	stream
		crlf;
		<< 'this.assert(';
		space;
		<<
			(PWBTypeValueResolver
				resolveValue: behaviorReturnValue mrlValue
				withType: originalBehavior returnType name);
		space;
		<< '=';
		space;
		<< 'l_result';
		nextPut: $);
		crlf.
	^ stream
]

{ #category : #printing }
PWBFunctionWithDataWindowParametersUnitAssertion >> printParameterInitializationOn: stream [
	self pwbParameters
		do: [ :param | 
			param isPWBDataWindow
				ifFalse: [ stream
						<< param parameter_name;
						space;
						nextPut: $=;
						space;
						<<
							(PWBTypeValueResolver
								resolveValue: param parameter_before_value
								withType: param parameterType name);
						space;
						crlf ] ].
	^ stream
]

{ #category : #printing }
PWBFunctionWithDataWindowParametersUnitAssertion >> printWindowDwSetUpOn: stream [
	^ stream
		<<
			(DatawindowValueResolver
				resolve: (self pwbParameters detect: [ :param | param isPWBDataWindow ]))
]
