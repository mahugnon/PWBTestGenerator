Class {
	#name : #PWBFunctionTestGenerationTest,
	#superclass : #TestCase,
	#instVars : [
		'testFunction',
		'testModel'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #'as yet unclassified' }
PWBFunctionTestGenerationTest >> dwDataExample [
]

{ #category : #running }
PWBFunctionTestGenerationTest >> setUp [
	testModel := FamixPWBModel new.
	testFunction := FamixPWBFunction new
		name: 'testFunction';
		mooseModel: testModel.
	PharoDatabaseAccessor DefaultDriver isNil
		ifNil: [ PharoDatabaseAccessor DefaultDriver: P3DatabaseDriver ]
]

{ #category : #tests }
PWBFunctionTestGenerationTest >> testNonVisualObjetCreationScript [
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
PWBFunctionTestGenerationTest >> testPWBParametersInitialization [
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
PWBFunctionTestGenerationTest >> testPWBReturnInitialization [
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
PWBFunctionTestGenerationTest >> testSetUpDataWindowParameter [
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
PWBFunctionTestGenerationTest >> testVisualObjetCreationScript [
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
