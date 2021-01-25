Class {
	#name : #PWBTestAssertionGenerationTest,
	#superclass : #PWBAbstractTestGenerationTest,
	#instVars : [
		'testParam1',
		'testParam2'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #tests }
PWBTestAssertionGenerationTest >> testBehaviorInvocationWithDWParam [
	| dwTestData script param testParam |
	testParam := FamixPWBParameter new
		name: 'param1';
		parameterType: (FamixPWBCustomType named: 'datawindow');
		mooseModel: testModel;
		behavioral: testFunction.
	dwTestData := 'DLQ_AOC,DLQ_DAC
1,0'.
	param := MrlParameter new
		parameter_name: 'param1';
		originalParameter: testParam;
		parameter_before_value: (MrlParameter_before_value new parameter_value: dwTestData).
	script := String
		streamContents: [ :stream | 
			(PWBBehaviorInvocation behaviorUnderTest: testFunction)
				pwbParameters: {param};
				printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'l_result = luo_testObject.testFunction(lw_PBUnitTest_window.dw_before)
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testGlobalFunctionWithDWParam [
	| dwTestData script param testParam |
	testFunction
		name: 'f_myglobal';
		accessModifier: 'global'.
	testParam := FamixPWBParameter new
		name: 'param1';
		parameterType: (FamixPWBCustomType named: 'datawindow');
		mooseModel: testModel;
		behavioral: testFunction.
	dwTestData := 'DLQ_AOC,DLQ_DAC
1,0'.
	param := MrlParameter new
		parameter_name: 'param1';
		originalParameter: testParam;
		parameter_before_value: (MrlParameter_before_value new parameter_value: dwTestData).
	script := String
		streamContents: [ :stream | 
			(PWBBehaviorInvocation behaviorUnderTest: testFunction)
				pwbParameters: {param};
				printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'l_result = f_myglobal(lw_PBUnitTest_window.dw_before)
'
]
