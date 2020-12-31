Class {
	#name : #PWBTestEventGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'testEventGenerator',
		'testModel',
		'testFunction',
		'testParam1',
		'mrlBehavior',
		'stream'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #tests }
PWBTestEventGeneratorTest >> script [
	^ stream contents copyReplaceAll: String crlf with: String cr
]

{ #category : #running }
PWBTestEventGeneratorTest >> setUp [
	stream := WriteStream on: String new.
	testModel := FamixPWBModel new.
	testFunction := FamixPWBFunction
		named: 'testFunction'
		model: testModel.
	testParam1 := (FamixPWBParameter named: 'testParam1' model: testModel)
		parameterType: (FamixPWBBasicType named: 'string');
		behavioral: testFunction.
	mrlBehavior := MrlBehavior new
		behavior_name: 'testFunction';
		pwb_object: 'uo_test';
		behaviorUnderTest: testFunction.
	testEventGenerator := PWBTestEventGenerator new.
	testEventGenerator mrlBehavior: mrlBehavior
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testBasicTypeParameterDeclarationOn [
	testEventGenerator mrlBehavior: mrlBehavior.
	testEventGenerator parameterDeclarationOn: stream.
	self
		assert: self script
		equals:
			'string lestParam1
'
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testBehaviorInvocationTimestamp [
	testFunction accessModifier: 'public'.
	testEventGenerator behaviorInvocationTimestamp: '0' on: stream.
	self
		assert: self script
		equals:
			'l_result = luo_test.testFunction(lestParam1 )
'
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testDwTypeParameterDeclarationOn [
	testParam1 parameterType: (FamixPWBCustomType named: 'uo_datawindow').
	testEventGenerator parameterDeclarationOn: stream.
	self
		assert: self script
		equals:
			'w_PBUnitTest_window lw_PBUnitTest_window
open(lw_PBUnitTest_window)
lw_PBUnitTest_window.hide()
'
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testFooterEventOn [
	testEventGenerator footerEventOn: stream.
	self assert: self script equals: 'end event'
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testInstanceVariableAssertTimestamp [
	self skip
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testInstanceVariableInitializationTimestamp [
	self skip
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testOwnerObjectOn [
	testEventGenerator ownerObjectOn: stream.
	self
		assert: self script
		equals:
			'uo_test luo_test
luo_test = create uo_test
'
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testParameterInitializationTimestamp [
		self skip
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testPrintPWBScriptOn [
		self skip
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testPrintPWBScriptTimestamp [
	self skip
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testReturnAssertTimestamp [
	mrlBehavior addMrlReturnValue: MrlReturnValue new.
	testEventGenerator returnAssertTimestamp: '0' on: stream.
	self assert: self script isEmpty.
	
	mrlBehavior
		addMrlReturnValue:
			(MrlReturnValue new
				mrlValue: '6';
				timestamp: '0').
	testFunction returnType: (FamixPWBBasicType named: 'integer').
	testEventGenerator returnAssertTimestamp: '0' on: stream.
	self
		assert: self script
		equals:
			'this.assert( 6 = l_result)
'
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testReturnDeclarationOn [
	testFunction returnType: (FamixPWBBasicType named: 'string').
	testEventGenerator mrlBehavior: mrlBehavior.
	testEventGenerator returnDeclarationOn: stream.
	self
		assert: self script
		equals:
			'string l_result
'
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testReturnNil [
	| return |
	return := MrlReturnValue new.
	testEventGenerator return: return on: stream.
	self
		assert: self script
		equals:
			'this.assert( IsNull( l_result ))
'
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testReturnValue [
	| return |
	return := MrlReturnValue new mrlValue: '6'.
	testFunction returnType: (FamixPWBBasicType named: 'integer').
	testEventGenerator return: return on: stream.
	self
		assert: self script
		equals:
			'this.assert( 6 = l_result)
'
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testheaderEventOn [
	testEventGenerator mrlBehavior: mrlBehavior.
	testEventGenerator headerEventOn: stream.
	self
		assert: self script
		equals:
			'event test_testFunction();

'
]
