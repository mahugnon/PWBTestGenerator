Class {
	#name : #PWBTestCaseGenerationTest,
	#superclass : #PWBAbstractTestGenerationTest,
	#instVars : [
		'testSuite',
		'testFunctionData'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #'as yet unclassified' }
PWBTestCaseGenerationTest >> createTestData [
	testFunctionData := MrlBehavior new
		behavior_name: 'testFunction';
		pwb_object: 'uo_testObject'.
	testFunctionData
		addMrlReturnValue: (MrlReturnValue new mrlValue: '1');
		behaviorUnderTest: testFunction.
	testSuite testUnits anyOne mrlBehavior: testFunctionData
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
	self createTestData.
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
PWBTestCaseGenerationTest >> testPrintPWBScripForFunctionWithDataStoreArgument [
	| script |
	self flag: #todo.
	script := String
		streamContents: [ :stream | testSuite printPWBScriptOn: stream ].

]

{ #category : #tests }
PWBTestCaseGenerationTest >> testPrintPWBScripForFunctionWithDataWindowArguments [
	| script |
	self flag: #todo.
	script := String
		streamContents: [ :stream | testSuite printPWBScriptOn: stream ].

]

{ #category : #tests }
PWBTestCaseGenerationTest >> testPrintPWBScripForFunctionWithOutArgument [
	| script |
	testSuite behaviorUnderTest: testFunction.
	self createTestData.
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
PWBTestCaseGenerationTest >> testSetBehaviorUnderTest [
	testSuite behaviorUnderTest: testFunction.
	self assert: testSuite testUnits isNotEmpty
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
