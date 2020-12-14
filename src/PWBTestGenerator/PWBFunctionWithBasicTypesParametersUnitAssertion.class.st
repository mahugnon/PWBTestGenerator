Class {
	#name : #PWBFunctionWithBasicTypesParametersUnitAssertion,
	#superclass : #PWBAbstractParametersUnitAssertion,
	#category : #'PWBTestGenerator-Assertions'
}

{ #category : #printing }
PWBFunctionWithBasicTypesParametersUnitAssertion >> printFunctionInvocationScriptOn: stream [
	| param |
	stream
		<< 'l_result = ';
		<< 'l_';
		<< self behaviorParent;
		nextPut: $.;
		<< self behaviorName;
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
PWBFunctionWithBasicTypesParametersUnitAssertion >> printPWBScriptOn: stream [
	self printParametersInitializationOn: stream.
	self printFunctionInvocationScriptOn: stream.
	self printAccessAssertionOn: stream.
	self printReturnAssertionOn: stream.
	^ stream
]

{ #category : #printing }
PWBFunctionWithBasicTypesParametersUnitAssertion >> printParametersInitializationOn: stream [
	self pwbParameters
		do:
			[ :param | PWBTypeValueSolver printParameter: param on: stream ]
]
