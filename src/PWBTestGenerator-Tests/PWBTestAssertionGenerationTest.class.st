Class {
	#name : #PWBTestAssertionGenerationTest,
	#superclass : #PWBAbstractTestGenerationTest,
	#instVars : [
		'testParam1',
		'testParam2'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #running }
PWBTestAssertionGenerationTest >> createParams [
	testParam1 := FamixPWBParameter new
		name: 'testParam1';
		parameterType: (FamixPWBBasicType named: 'string');
		sourceAnchor: (FamixPWBIndexedFileAnchor new startPos: 1).
	testParam2 := FamixPWBParameter new
		name: 'testParam2';
		parameterType: (FamixPWBCustomType named: 'datawindow');
		sourceAnchor: (FamixPWBIndexedFileAnchor new startPos: 3)
]

{ #category : #running }
PWBTestAssertionGenerationTest >> setUp [
	super setUp.
	self createTestVariables.
	self createAccesses.
	self createParams
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testAttributeAccessedIsBasicTypeAssertion [
	| script |
	script := String
		streamContents: [ :stream | 
			PWBAccessBasedAssertion new
				behaviorAccesses: {access1};
				printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'this.assert(after1=luo_testObject.testAttribute1)
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testBasicTypeInitializeAccess [
	| script |
	self createAccesses.
	script := String
		streamContents: [ :stream | 
			PWBTestCaseInitializer new
				behaviorAccesses: {access1};
				printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'luo_testObject.testAttribute1 = "before1"
'
]

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
			PWBBehaviorInvocation new
				behaviorUnderTest: testFunction;
				pwbParameters: {param};
				printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'l_result = luo_testObject.testFunction(lw_PBUnitTest_window.dw_before)
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testCreateDataControlAccessAssertionOn [
	| script |
	access1 beforeValue dataobject: 'dw_test'.
	access1
		afterValue:
			(MrlVariableAccessAfterValue new
				dataobject: 'dw_test';
				mrlvalue: 'DLQ_AOC,DLQ_DAC' , String cr , '0,1' , String lf).
	script := String
		streamContents: [ :stream | 
			(PWBAccessBasedAssertion assertionFor: {access1})
				printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'this.assert(luo_testObject.testAttribute1.dataobject = "dw_test")
this.assert(f_get_datacontrol_content(luo_testObject.testAttribute1) = "DLQ_AOC,DLQ_DAC0,1")
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testDataControlAccessInitializationOn [
	| script |
	access1
		beforeValue:
			(MrlVariableAccessAfterValue new
				dataobject: 'dw_test';
				mrlvalue: 'DLQ_AOC,DLQ_DAC' , String cr , '0,1' , String lf).
	script := String
		streamContents: [ :stream | 
			(PWBTestCaseInitializer params: #() accesses: {access1})
				printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'luo_testObject.testAttribute1.reset()
luo_testObject.testAttribute1.dataobject = "dw_test"
luo_testObject.testAttribute1.insertRow(0)
luo_testObject.testAttribute1.setItem(luo_testObject.testAttribute1.rowcount(),"DLQ_AOC",f_mrl_parse( "0",luo_testObject.testAttribute1.object.DLQ_AOC.colType))
luo_testObject.testAttribute1.setItem(luo_testObject.testAttribute1.rowcount(),"DLQ_DAC",f_mrl_parse( "1",luo_testObject.testAttribute1.object.DLQ_DAC.colType))
'
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
PWBTestAssertionGenerationTest >> testPWBInitializeDataStoreParam [
	| script localTestParam1 dwTestData |
	dwTestData := 'DLQ_AOC,DLQ_DAC
1,0'.
	testParam2 parameterType: (FamixPWBCustomType named: 'datastore').
	localTestParam1 := MrlParameter new
		parameter_name: 'testParam2';
		originalParameter: testParam2;
		parameter_before_value:
			(MrlParameter_before_value new
				parameter_dataobject: 'dw_test';
				parameter_value: dwTestData).
	script := String
		streamContents: [ :stream | 
			(PWBTestCaseInitializer params: {localTestParam1} accesses: #())
				printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'lestParam2_before = create datastore
lestParam2_before.dataobject ="dw_test"
lestParam2_before.setTrans(SQLCA)
lestParam2_before.insertRow(0)
lestParam2_before.setItem(lestParam2_before.rowcount(),"DLQ_AOC",f_mrl_parse( "1",lestParam2_before.object.DLQ_AOC.colType))
lestParam2_before.setItem(lestParam2_before.rowcount(),"DLQ_DAC",f_mrl_parse( "0",lestParam2_before.object.DLQ_DAC.colType))
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testPWBInitializeNilInvocationVariable [
	| script localParam |
	localParam := MrlParameter new
		parameter_name: 'testParam1';
		parameter_before_value: (MrlParameter_before_value new parameter_value: nil);
		originalParameter: testParam1.
	script := String
		streamContents: [ :stream | 
			(PWBTestCaseInitializer params: {localParam} accesses: #())
				printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'SetNull(lestParam1)
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testPWBInitializeParams [
	| script localTestParam1 dwTestData localTestParam2 |
	dwTestData := 'DLQ_AOC,DLQ_DAC
1,0'.
	localTestParam1 := MrlParameter new
		parameter_name: 'testParam1';
		originalParameter: testParam1;
		parameter_before_value: (MrlParameter_before_value new parameter_value: 'hello').
	localTestParam2 := MrlParameter new
		parameter_name: 'testParam2';
		originalParameter: testParam2;
		parameter_before_value:
			(MrlParameter_before_value new
				parameter_dataobject: 'dw_test';
				parameter_value: dwTestData).
	script := String
		streamContents: [ :stream | 
			(PWBTestCaseInitializer
				params:
					{localTestParam1.
					localTestParam2}
				accesses: #()) printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'lw_PBUnitTest_window.dw_before.dataobject = "dw_test"
lw_PBUnitTest_window.dw_before.setTrans(SQLCA)
lw_PBUnitTest_window.dw_before.insertRow(0)
lw_PBUnitTest_window.dw_before.setItem(lw_PBUnitTest_window.dw_before.rowcount(),"DLQ_AOC",f_mrl_parse( "1",lw_PBUnitTest_window.dw_before.object.DLQ_AOC.colType))
lw_PBUnitTest_window.dw_before.setItem(lw_PBUnitTest_window.dw_before.rowcount(),"DLQ_DAC",f_mrl_parse( "0",lw_PBUnitTest_window.dw_before.object.DLQ_DAC.colType))
lestParam1 = "hello"
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testPWBParametersDeclaration [
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
			PWBFunctionWithBasicTypeArgumentsUnitTest new
				behaviorUnderTest: testFunction;
				printParametersDeclarationOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'string ls_param1
integer li_param2
'
]

{ #category : #tests }
PWBTestAssertionGenerationTest >> testPWBReturnDeclaration [
	| script |
	testFunction returnType: (FamixPWBBasicType new name: 'string').
	script := String
		streamContents: [ :stream | 
			PWBFunctionWithBasicTypeArgumentsUnitTest new
				behaviorUnderTest: testFunction;
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
	utility := PWBReturnBasedUnitAssertionWithBasicTypeParam new
		behaviorReturnValue: (MrlReturnValue new mrlValue: '3');
		behaviorUnderTest: testFunction.
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
	| dwTestData script param testParam |
	dwTestData := 'DLQ_AOC,DLQ_DAC
1,0'.
	testParam := FamixPWBParameter new
		name: 'param1';
		parameterType: (FamixPWBCustomType named: 'datawindow');
		mooseModel: testModel;
		behavioral: testFunction.
	param := MrlParameter new
		originalParameter: testParam;
		parameter_before_value:
			(MrlParameter_before_value new
				parameter_value: dwTestData;
				parameter_dataobject: 'dw_dlq').
	script := String
		streamContents: [ :stream | 
			(PWBTestCaseInitializer params: {param} accesses: #())
				printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
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
