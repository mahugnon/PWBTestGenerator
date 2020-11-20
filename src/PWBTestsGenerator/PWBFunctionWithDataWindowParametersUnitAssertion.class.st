Class {
	#name : #PWBFunctionWithDataWindowParametersUnitAssertion,
	#superclass : #PWBAbstractParametersUnitAssertion,
	#category : #'PWBTestsGenerator-assertions'
}

{ #category : #printing }
PWBFunctionWithDataWindowParametersUnitAssertion >> printFunctionInvocationScriptOn: stream [
	| param localVar |
	self printParameterInitializationOn: stream.
	localVar := 'l_' , behaviorParent.
	stream
		<< 'l_result = ';
		<< localVar;
		nextPut: $.;
		<< behaviorName;
		nextPut: $(.
	1 to: self mrlParameters size - 1 do: [ :iter | 
		param := self mrlParameters at: iter.
		param isPWBDataWindow
			ifTrue: [ stream
					<< 'lw_maryline_test_window.dw_input';
					space;
					nextPut: $, ]
			ifFalse: [ stream
					<< param parameter_name;
					space;
					nextPut: $, ] ].
	param := self mrlParameters last.
	param isPWBDataWindow
		ifTrue: [ stream << 'lw_maryline_test_window.dw_input' ]
		ifFalse: [ stream
				<< param parameter_name;
				space;
				nextPut: $) ].
	^ stream
]

{ #category : #printing }
PWBFunctionWithDataWindowParametersUnitAssertion >> printPWBDeclarationScriptOn: stream [
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
	self mrlParameters
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
	^ (MarylineDWFieldTypeExtractor
		parameter: (self mrlParameters detect: [ :param | param isPWBDataWindow ]))
		extractOn: stream
]
