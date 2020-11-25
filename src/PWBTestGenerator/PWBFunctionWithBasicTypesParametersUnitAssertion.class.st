Class {
	#name : #PWBFunctionWithBasicTypesParametersUnitAssertion,
	#superclass : #PWBAbstractParametersUnitAssertion,
	#category : #'PWBTestGenerator-Assertions'
}

{ #category : #printing }
PWBFunctionWithBasicTypesParametersUnitAssertion >> assertNilOn: stream [
	stream
		<< 'this.assert(';
		space;
		<< 'IsNull(';
		space;
		<< 'l_result';
		space;
		nextPut: $);
		nextPut: $);
		crlf
]

{ #category : #printing }
PWBFunctionWithBasicTypesParametersUnitAssertion >> printFunctionInvocationScriptOn: stream [
	| param |
	self printInitializeInvocationVariablesOn: stream.
	stream
		<< behaviorName;
		nextPut: $(.
	1 to: self pwbParameters size - 1 do: [ :iter | 
		param := self pwbParameters at: iter.
		stream
			<< 'l';
			<< (param parameter_name copyFrom: 2 to: param parameter_name size);
			space;
			nextPut: $, ].
	param := self pwbParameters last.
	stream
		<< 'l';
		<< (param parameter_name copyFrom: 2 to: param parameter_name size);
		space;
		nextPut: $);
		crlf
]

{ #category : #printing }
PWBFunctionWithBasicTypesParametersUnitAssertion >> printInitializeInvocationVariablesOn: stream [
	self pwbParameters
		do: [ :param | 
			stream
				<< 'l';
				<< (param parameter_name copyFrom: 2 to: param parameter_name size);
				space;
				<< '=';
				space;
				<<
					(PWBTypeValueResolver
						resolveValue: param parameter_before_value
						withType: param parameterType name);
				crlf ].
	stream
		<< 'l_result = ';
		<< 'l_';
		<< behaviorParent;
		nextPut: $.
]

{ #category : #printing }
PWBFunctionWithBasicTypesParametersUnitAssertion >> printPWBScriptOn: stream [
	self printFunctionInvocationScriptOn: stream.
	self printReturnAssertionOn: stream.
	^ stream
]

{ #category : #printing }
PWBFunctionWithBasicTypesParametersUnitAssertion >> printReturnAssertionOn: stream [
	behaviorReturnValue mrlValue
		ifNil: [ self assertNilOn: stream ]
		ifNotNil: [ stream
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
				crlf ].
	^ stream
]
