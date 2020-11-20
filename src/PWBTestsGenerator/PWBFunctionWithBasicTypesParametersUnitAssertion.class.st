Class {
	#name : #PWBFunctionWithBasicTypesParametersUnitAssertion,
	#superclass : #PWBAbstractParametersUnitAssertion,
	#category : #'PWBTestsGenerator-assertions'
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
	| param localVar |
	localVar := 'l_' , behaviorParent.
	stream
		<< 'l_result = ';
		<< localVar;
		nextPut: $.;
		<< behaviorName;
		nextPut: $(.
	1 to: self mrlParameters size - 1 do: [ :iter | 
		param := self mrlParameters at: iter.
		stream
			<<
				(PWBTypeValueResolver
					resolveValue: param parameter_before_value
					withType: param parameterType name);
			space;
			nextPut: $, ].
	param := self mrlParameters last.
	stream
		<<
			(PWBTypeValueResolver
				resolveValue: param parameter_before_value
				withType: param parameterType name);
		space;
		nextPut: $);
		crlf
]

{ #category : #printing }
PWBFunctionWithBasicTypesParametersUnitAssertion >> printPWBDeclarationScriptOn: stream [
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
