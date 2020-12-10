Class {
	#name : #PWBTestAssertionGenerationTest,
	#superclass : #TestCase,
	#instVars : [
		'testFunction',
		'testModel'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #'as yet unclassified' }
PWBTestAssertionGenerationTest >> dwDataExample [
]

{ #category : #running }
PWBTestAssertionGenerationTest >> setUp [
	| testObject |
	testModel := FamixPWBModel new.
	testObject := FamixPWBUserObject new
		name: 'testObject';
		mooseModel: testModel.
	testFunction := FamixPWBFunction new
		name: 'testFunction';
		parentType: testObject;
		mooseModel: testModel.
	PharoDatabaseAccessor DefaultDriver isNil
		ifNil: [ PharoDatabaseAccessor DefaultDriver: P3DatabaseDriver ]
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testNonVisualObjetCreationScript [
	| script |
	script := String
		streamContents:
			[ :stream | PWBTestObjectCreator createAndInitialize: 'uo_liq_cal' on: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'uo_liq_cal luo_liq_cal
luo_liq_cal = create uo_liq_cal
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testPWBFunctionInvocation [
	| script testParam1 testParam2 |
	testParam1 := Mock named: 'testParam1'.
	testParam1 stub parameter_before_value willReturn: 'hallo'.
	testParam1 stub parameter_name willReturn: 'testParam1'.
	testParam1 stub parameterType
		willReturn: (FamixPWBBasicType new name: 'string').
	testParam2 := Mock named: 'testParam2'.
	testParam2 stub parameter_before_value willReturn: '3'.
	testParam2 stub parameter_name willReturn: 'testParam2'.
	testParam2 stub parameterType
		willReturn: (FamixPWBBasicType new name: 'integer').
	script := String
		streamContents: [ :stream | 
			PWBFunctionWithBasicTypesParametersUnitAssertion new
				pwbParameters:
					{testParam1.
					testParam2};
				functionUnderTest: testFunction;
				printParametersInitializationOn: stream;
				printFunctionInvocationScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'lestParam2 = 3
lestParam1 = "hallo"
l_result = l_testObject.testFunction(lestParam2 ,lestParam1 )
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testPWBInitializeInvocationVariables [
	| script testParam1 testParam2 |
	testParam1 := Mock named: 'testParam1'.
	testParam1 stub parameter_before_value willReturn: 'hallo'.
	testParam1 stub parameter_name willReturn: 'testParam1'.
	testParam1 stub parameterType
		willReturn: (FamixPWBBasicType new name: 'string').
	testParam2 := Mock named: 'testParam2'.
	testParam2 stub parameter_before_value willReturn: '3'.
	testParam2 stub parameter_name willReturn: 'testParam2'.
	testParam2 stub parameterType
		willReturn: (FamixPWBBasicType new name: 'integer').
	script := String
		streamContents: [ :stream | 
			PWBFunctionWithBasicTypesParametersUnitAssertion new
				functionUnderTest: testFunction;
				pwbParameters:
					{testParam1.
					testParam2};
				printParametersInitializationOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'lestParam2 = 3
lestParam1 = "hallo"
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testPWBParametersInitialization [
	| script |
	FamixPWBParameter new
		name: 'as_param1';
		parameterType: (FamixPWBBasicType new name: 'string');
		mooseModel: testModel;
		behavioral: testFunction.
	FamixPWBParameter new
		name: 'ai_param2';
		parameterType: (FamixPWBBasicType new name: 'integer');
		mooseModel: testModel;
		behavioral: testFunction.
	script := String
		streamContents: [ :stream | 
			PWBUnitTestForFunctionWithBasicTypeArguments new
				functionUnderTest: testFunction;
				printParametersDeclarationOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'string ls_param1
integer li_param2
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testPWBReturnInitialization [
	| script |
	testFunction returnType: (FamixPWBBasicType new name: 'string').
	script := String
		streamContents: [ :stream | 
			PWBUnitTestForFunctionWithBasicTypeArguments new
				functionUnderTest: testFunction;
				printReturnValueDeclarationOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'string l_result
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testReturnAssertionScript [
	| utility result |
	testFunction returnType: (FamixPWBBasicType new name: 'integer').
	utility := PWBFunctionWithBasicTypesParametersUnitAssertion new
		behaviorReturnValue: (MrlReturnValue new mrlValue: '3');
		functionUnderTest: testFunction.
	result := String
		streamContents: [ :stream | utility printReturnAssertionOn: stream ].
	self
		assert: (result copyReplaceAll: String crlf with: String cr)
		equals:
			'this.assert( 3 = l_result)
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testSetUpDataWindowParameter [
	| dwTestData result param |
	dwTestData := 'DLQ_AOC,DLQ_DAC
1,0'.
	param := MrlParameter new
		parameter_dataobject: 'dw_dlq';
		parameter_before_value: (MrlParameter_before_value new parameter_value: dwTestData).
	result := DatawindowValueSolver resolve: param.
	self
		assert: (result copyReplaceAll: String crlf with: String cr)
		equals:
			'lw_PBUnitTest_window.dw_before.dataobject = "dw_dlq"
lw_PBUnitTest_window.dw_before.setTrans(SQLCA)
lw_PBUnitTest_window.dw_before.insertRow(0)
lw_PBUnitTest_window.dw_before.setItem(lw_PBUnitTest_window.dw_before.rowcount(),"DLQ_AOC",f_mrl_parse( "1",lw_PBUnitTest_window.dw_before.object.DLQ_AOC.colType))
lw_PBUnitTest_window.dw_before.setItem(lw_PBUnitTest_window.dw_before.rowcount(),"DLQ_DAC",f_mrl_parse( "0",lw_PBUnitTest_window.dw_before.object.DLQ_DAC.colType))
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testVisualObjetCreationScript [
	| script |
	script := String
		streamContents: [ :stream | 
			PWBTestObjectCreator
				createAndInitialize: 'w_saisie_liquidation'
				on: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'w_saisie_liquidation lw_saisie_liquidation
open(lw_saisie_liquidation)
lw_saisie_liquidation.hide()
'
]
