Class {
	#name : #PWBTestBehaviorCreatorTest,
	#superclass : #TestCase,
	#instVars : [
		'testModel',
		'testFunction',
		'testParam1',
		'mrlBehavior'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #running }
PWBTestBehaviorCreatorTest >> setUp [
	testModel := FamixPWBModel new.
	testFunction := FamixPWBFunction
		named: 'testFunction'
		model: testModel.
	testParam1 := (FamixPWBParameter named: 'testParam1' model: testModel)
		parameterType: (FamixPWBBasicType named: 'string');
		behavioral: testFunction.
	mrlBehavior := MrlBehavior new
		behavior_name: 'testFunction';
		pwb_object: 'test_uo';
		behaviorUnderTest: testFunction
]

{ #category : #tests }
PWBTestBehaviorCreatorTest >> testFunctionInvocation [
	| script |
	script := String
		streamContents:
			[ :stream | PWBTestFunctionCreator new behaviorInvocation: mrlBehavior on: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'l_result = ltest_uo.testFunction(lestParam1 )
'
]

{ #category : #tests }
PWBTestBehaviorCreatorTest >> testFunctionInvocationWithDwParam [
	| script |
	testParam1 parameterType: (FamixPWBCustomType named: 'datawindow').
	script := String
		streamContents:
			[ :stream | PWBTestFunctionCreator new behaviorInvocation: mrlBehavior on: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'l_result = ltest_uo.testFunction(lw_PBUnitTest_window.dw_before)
'
]

{ #category : #tests }
PWBTestBehaviorCreatorTest >> testGlobalFunctionInvocation [
	| script |
	testFunction name: 'f_testFunction'.
	mrlBehavior
		behavior_name: 'f_testFunction';
		pwb_object: 'f_testFunction'.
	script := String
		streamContents: [ :stream | 
			PWBTestGlobalFunctionCreator new
				behaviorInvocation: mrlBehavior
				on: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'l_result = f_testFunction(lestParam1 )
'
]

{ #category : #tests }
PWBTestBehaviorCreatorTest >> testPWBTestFunctionCreatorAccept [
	testFunction accessModifier: 'public'.
	self assert: (PWBTestFunctionCreator accept: mrlBehavior)
]

{ #category : #tests }
PWBTestBehaviorCreatorTest >> testPWBTestGlobalFunctionCreatorAccept [
	testFunction accessModifier: 'global'.
	self assert: (PWBTestGlobalFunctionCreator accept: mrlBehavior)
]

{ #category : #tests }
PWBTestBehaviorCreatorTest >> testPWBTestSubroutineCreatorAccept [
	mrlBehavior
		behaviorUnderTest: (FamixPWBSubRoutine named: 'testFunction').
	self assert: (PWBTestSubroutineCreator accept: mrlBehavior)
]

{ #category : #tests }
PWBTestBehaviorCreatorTest >> testSubroutineInvocation [
	| script |
	script := String
		streamContents: [ :stream | 
			PWBTestSubroutineCreator new
				behaviorInvocation: mrlBehavior
				on: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'ltest_uo.testFunction(lestParam1 )
'
]
