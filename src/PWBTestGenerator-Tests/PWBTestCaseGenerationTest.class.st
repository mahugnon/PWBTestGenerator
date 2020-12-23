Class {
	#name : #PWBTestCaseGenerationTest,
	#superclass : #PWBAbstractTestGenerationTest,
	#instVars : [
		'testSuite',
		'testFunctionData'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #tests }
PWBTestCaseGenerationTest >> createSubroutineData [
	| param1 testSubroutine testSubroutineData mrlParam |
	testSubroutine := FamixPWBSubRoutine new
		name: 'testSubroutine';
		parentType: testObject;
		mooseModel: testModel.
	param1 := FamixPWBParameter new
		name: 'param1';
		parameterType: (FamixPWBBasicType named: 'string').
	testSubroutine addParameter: param1.
	testSuite behaviorUnderTest: testSubroutine.
	testSubroutineData := MrlBehavior new
		behavior_name: 'testSubroutine';
		pwb_object: 'uo_testObject';
		behaviorUnderTest: testSubroutine.
	testSuite pwbunitTestClass mrlBehavior: testSubroutineData.
	mrlParam := MrlParameter new
		originalParameter: param1;
		parameter_name: 'param1';
		timestamp: '6';
		parameter_after_value: (MrlParameter_after_value new parameter_value: 'after');
		parameter_before_value: (MrlParameter_before_value new parameter_value: 'before').
	testSubroutineData
		addMrlInstanceVariablesAccess: access1;
		addMrlParameter: mrlParam
]

{ #category : #'as yet unclassified' }
PWBTestCaseGenerationTest >> createTestFunctionData [
	testFunctionData := MrlBehavior new
		behavior_name: 'testFunction';
		pwb_object: 'uo_testObject'.
	testFunctionData
		addMrlReturnValue:
			(MrlReturnValue new
				mrlValue: '1';
				timestamp: '12');
		behaviorUnderTest: testFunction.
	testSuite pwbunitTestClass mrlBehavior: testFunctionData
]

{ #category : #tests }
PWBTestCaseGenerationTest >> setUp [
	super setUp.
	self createTestVariables.
	self createAccesses.
	testFunction
		returnType: (FamixPWBBasicType named: 'string');
		addReturn:
			(FamixPWBFunctionReturn new
				returnValue: 'hello world';
				type: (FamixPWBBasicType named: 'string');
				mooseModel: testModel).
	testSuite := PWBTestSuite new
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testFileDeclaredType [
	| script |
	testSuite behaviorUnderTest: testFunction.
	script := testSuite fileDeclaredType
		copyReplaceAll: String lf
		with: String cr.
	self
		assert: script
		equals:
			'global type test_testFunction_case from testcase

event test_testFunction ()

end type

global test_testFunction_case test_testFunction_case

'
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testForward [
	| script |
	testSuite behaviorUnderTest: testFunction.
	script := testSuite forward copyReplaceAll: String lf with: String cr.
	self
		assert: script
		equals:
			'forward

global type test_testFunction_case from testcase

end type

end forward

'
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testOnCreateEvent [
	| script |
	testSuite behaviorUnderTest: testFunction.
	script := testSuite onCreate
		copyReplaceAll: String lf
		with: String cr.
	self
		assert: script
		equals:
			'on test_testFunction_case.create

call super::create

end on'
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testOnDestroyEvent [
	| script |
	testSuite behaviorUnderTest: testFunction.
	script := testSuite onDestroy
		copyReplaceAll: String lf
		with: String cr.
	self
		assert: script
		equals:
			'on test_testFunction_case.destroy

call super::destroy

end on'
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testPrintPWBScripForFunctionWithBasicTypeArguments [
	| script param1 |
	param1 := FamixPWBParameter new
		name: 'param1';
		parameterType: (FamixPWBBasicType named: 'string').
	testFunction addParameter: param1.
	testSuite behaviorUnderTest: testFunction.
	self createTestFunctionData.
	testFunctionData
		addMrlParameter:
			(MrlParameter new
				originalParameter: param1;
				parameter_name: 'param1';
				parameter_after_value: (MrlParameter_after_value new parameter_value: 'after');
				parameter_before_value: (MrlParameter_before_value new parameter_value: 'before')).
	script := String
		streamContents: [ :stream | testSuite printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String lf with: String cr)
		equals: '$PBExportHeader$test_testFunction_case.sru

forward

global type test_testFunction_case from testcase

end type

end forward

global type test_testFunction_case from testcase

event test_testFunction ()

end type

global test_testFunction_case test_testFunction_case



event test_testFunction();



uo_testObject luo_testObject

luo_testObject = create uo_testObject

string l_result

string laram1

laram1 = "before"

l_result = luo_testObject.testFunction(laram1 )

this.assert( "1" = l_result)

return;

end event





on test_testFunction_case.create

call super::create

end on

on test_testFunction_case.destroy

call super::destroy

end on'
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testPrintPWBScripForFunctionWithBasicTypeArgumentsWithAccess [
	| script param1 |
	param1 := FamixPWBParameter new
		name: 'param1';
		parameterType: (FamixPWBBasicType named: 'string').
	testFunction addParameter: param1.
	testSuite behaviorUnderTest: testFunction.
	self createTestFunctionData.
	testFunctionData
		addMrlInstanceVariablesAccess: access1;
		addMrlParameter:
			(MrlParameter new
				originalParameter: param1;
				parameter_name: 'param1';
				parameter_after_value: (MrlParameter_after_value new parameter_value: 'after');
				parameter_before_value: (MrlParameter_before_value new parameter_value: 'before')).
	script := String
		streamContents: [ :stream | testSuite printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String lf with: String cr)
		equals: '$PBExportHeader$test_testFunction_case.sru

forward

global type test_testFunction_case from testcase

end type

end forward

global type test_testFunction_case from testcase

event test_testFunction ()

end type

global test_testFunction_case test_testFunction_case



event test_testFunction();



uo_testObject luo_testObject

luo_testObject = create uo_testObject

string l_result

string laram1

laram1 = "before"

luo_testObject.testAttribute1 = "before1"

l_result = luo_testObject.testFunction(laram1 )

this.assert(after1=luo_testObject.testAttribute1)

this.assert( "1" = l_result)

return;

end event





on test_testFunction_case.create

call super::create

end on

on test_testFunction_case.destroy

call super::destroy

end on'
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testPrintPWBScripForFunctionWithDataStoreArgument [
	| param1 script |
	param1 := FamixPWBParameter new
		name: 'ds_param1';
		parameterType: (FamixPWBCustomType named: 'datastore').
	testFunction addParameter: param1.
	testSuite behaviorUnderTest: testFunction.
	self createTestFunctionData.
	testFunctionData
		addMrlParameter:
			(MrlParameter new
				originalParameter: param1;
				parameter_name: 'ds_param1';
				parameter_after_value:
					(MrlParameter_after_value new
						parameter_value: 'h1,h2' , String cr , 'afv1,afv2';
						parameter_dataobject: 'dw_test');
				parameter_before_value:
					(MrlParameter_before_value new
						parameter_value: 'h1,h2' , String cr , 'bv1,bv2';
						parameter_dataobject: 'dw_test')).
	script := String
		streamContents: [ :stream | testSuite printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String lf with: String cr)
		equals:
			'$PBExportHeader$test_testFunction_case.sru

forward

global type test_testFunction_case from testcase

end type

end forward

global type test_testFunction_case from testcase

event test_testFunction ()

end type

global test_testFunction_case test_testFunction_case



event test_testFunction();



uo_testObject luo_testObject

luo_testObject = create uo_testObject

string l_result

datastore ls_param1

ls_param1_before = create datastore

ls_param1_before.dataobject ="dw_test"

ls_param1_before.setTrans(SQLCA)

ls_param1_before.insertRow(0)

ls_param1_before.setItem(ls_param1_before.rowcount(),"h1",f_mrl_parse( "bv1",ls_param1_before.object.h1.colType))

ls_param1_before.setItem(ls_param1_before.rowcount(),"h2",f_mrl_parse( "bv2",ls_param1_before.object.h2.colType))

ls_param1_after = create datastore

ls_param1_after.dataobject ="dw_test"

ls_param1_after.setTrans(SQLCA)

ls_param1_after.insertRow(0)

ls_param1_after.setItem(ls_param1_after.rowcount(),"h1",f_mrl_parse( "afv1",ls_param1_after.object.h1.colType))

ls_param1_after.setItem(ls_param1_after.rowcount(),"h2",f_mrl_parse( "afv2",ls_param1_after.object.h2.colType))

l_result = luo_testObject.testFunction(ls_param1 )

this.assert( "1" = l_result)

return;

end event





on test_testFunction_case.create

call super::create

end on

on test_testFunction_case.destroy

call super::destroy

end on'
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testPrintPWBScripForFunctionWithDataWindowArguments [
	| param1 script |
	param1 := FamixPWBParameter new
		name: 'dw_param1';
		sourceAnchor: (FamixPWBIndexedFileAnchor new startPos: 2);
		parameterType: (FamixPWBCustomType named: 'datawindow').
	testFunction addParameter: param1.
	testSuite behaviorUnderTest: testFunction.
	self createTestFunctionData.
	testFunctionData
		addMrlParameter:
			(MrlParameter new
				originalParameter: param1;
				parameter_name: 'dw_param1';
				parameter_after_value:
					(MrlParameter_after_value new
						parameter_value: 'h1,h2' , String cr , 'afv1,afv2';
						parameter_dataobject: 'dw_test');
				parameter_before_value:
					(MrlParameter_before_value new
						parameter_value: 'h1,h2' , String cr , 'bv1,bv2';
						parameter_dataobject: 'dw_test')).
	script := String
		streamContents: [ :stream | testSuite printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String lf with: String cr)
		equals: '$PBExportHeader$test_testFunction_case.sru

forward

global type test_testFunction_case from testcase

end type

end forward

global type test_testFunction_case from testcase

event test_testFunction ()

end type

global test_testFunction_case test_testFunction_case



event test_testFunction();



uo_testObject luo_testObject

luo_testObject = create uo_testObject

w_PBUnitTest_window lw_PBUnitTest_window

open(lw_PBUnitTest_window)

lw_PBUnitTest_window.hide()

string l_result

lw_PBUnitTest_window.dw_before.dataobject = "dw_test"

lw_PBUnitTest_window.dw_before.setTrans(SQLCA)

lw_PBUnitTest_window.dw_before.insertRow(0)

lw_PBUnitTest_window.dw_before.setItem(lw_PBUnitTest_window.dw_before.rowcount(),"h1",f_mrl_parse( "bv1",lw_PBUnitTest_window.dw_before.object.h1.colType))

lw_PBUnitTest_window.dw_before.setItem(lw_PBUnitTest_window.dw_before.rowcount(),"h2",f_mrl_parse( "bv2",lw_PBUnitTest_window.dw_before.object.h2.colType))

lw_PBUnitTest_window.dw_after.dataobject = "dw_test"

lw_PBUnitTest_window.dw_after.setTrans(SQLCA)

lw_PBUnitTest_window.dw_after.insertRow(0)

lw_PBUnitTest_window.dw_after.setItem(lw_PBUnitTest_window.dw_after.rowcount(),"h1",f_mrl_parse( "afv1",lw_PBUnitTest_window.dw_after.object.h1.colType))

lw_PBUnitTest_window.dw_after.setItem(lw_PBUnitTest_window.dw_after.rowcount(),"h2",f_mrl_parse( "afv2",lw_PBUnitTest_window.dw_after.object.h2.colType))

l_result = luo_testObject.testFunction(lw_PBUnitTest_window.dw_before)

this.assert( "1" = l_result)

return;

end event





on test_testFunction_case.create

call super::create

end on

on test_testFunction_case.destroy

call super::destroy

end on'
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testPrintPWBScripForFunctionWithOutArgument [
	| script |
	testSuite behaviorUnderTest: testFunction.
	self createTestFunctionData.
	script := String
		streamContents: [ :stream | testSuite printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String lf with: String cr)
		equals: '$PBExportHeader$test_testFunction_case.sru

forward

global type test_testFunction_case from testcase

end type

end forward

global type test_testFunction_case from testcase

event test_testFunction ()

end type

global test_testFunction_case test_testFunction_case



event test_testFunction();



uo_testObject luo_testObject

luo_testObject = create uo_testObject

string l_result

l_result = luo_testObject.testFunction()

this.assert( "1" = l_result)

return;

end event





on test_testFunction_case.create

call super::create

end on

on test_testFunction_case.destroy

call super::destroy

end on'
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testPrintPWBScripForSubRoutineWithAccess [
	| script |
	self createSubroutineData.
	script := String
		streamContents: [ :stream | testSuite printPWBScriptOn: stream ].
	self
		assert: (script copyReplaceAll: String lf with: String cr)
		equals: '$PBExportHeader$test_testSubroutine_case.sru

forward

global type test_testSubroutine_case from testcase

end type

end forward

global type test_testSubroutine_case from testcase

event test_testSubroutine ()

end type

global test_testSubroutine_case test_testSubroutine_case



event test_testSubroutine();



uo_testObject luo_testObject

luo_testObject = create uo_testObject

string laram1

laram1 = "before"

luo_testObject.testAttribute1 = "before1"

luo_testObject.testSubroutine(laram1 )

this.assert(after1=luo_testObject.testAttribute1)

return;

end event





on test_testSubroutine_case.create

call super::create

end on

on test_testSubroutine_case.destroy

call super::destroy

end on'
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testSetBehaviorUnderTest [
	testSuite behaviorUnderTest: testFunction.
	self assert: testSuite pwbunitTestClass isNotNil
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testTestCaseName [
	testSuite behaviorUnderTest: testFunction.
	self assert: testSuite testCaseName equals: 'test_testFunction'
]

{ #category : #tests }
PWBTestCaseGenerationTest >> testTestFileHeader [
	testSuite behaviorUnderTest: testFunction.
	self
		assert: (testSuite testFileHeader copyReplaceAll: String lf with: String cr)
		equals:
			'$PBExportHeader$test_testFunction_case.sru

'
]
