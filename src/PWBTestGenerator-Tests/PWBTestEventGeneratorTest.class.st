Class {
	#name : #PWBTestEventGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'testEventGenerator',
		'testModel',
		'testFunction',
		'testParam1',
		'mrlBehavior',
		'stream',
		'uo_test'
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
	uo_test := FamixPWBUserObject named: 'uo_test' model: testModel.
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
	| acc variable |
	FamixPWBInstanceVariable new
		name: 'testInstvar';
		parentType: uo_test;
		attributeType: (FamixPWBBasicType named: 'string');
		mooseModel: testModel.
	variable := MrlnstanceVariable new
		instance_variable_pwb_object: 'uo_test';
		instance_variable_name: 'testInstvar'.
	acc := MrlInstanceVariableAccess new variable: variable.
	mrlBehavior addMrlInstanceVariablesAccess: acc.
	testEventGenerator instanceVariableAssertTimestamp: '0' on: stream.
	self assert: self script isEmpty.
	mrlBehavior mrlBehaviorDatas: nil.
	acc
		mooseModel: testModel;
		instance_variable_access_timestamp: '0';
		beforeValue: (MrlVariableAccessAfterValue new mrlvalue: 'bf_aloba');
		afterValue: (MrlVariableAccessAfterValue new mrlvalue: 'af_aloba').
	testEventGenerator instanceVariableAssertTimestamp: '0' on: stream.
	self
		assert: self script
		equals:
			'this.assert("af_aloba" =luo_test.testInstvar)
'
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testInstanceVariableInitializationTimestamp [
	| acc variable |
	FamixPWBInstanceVariable new
		name: 'testInstvar';
		parentType: uo_test;
		attributeType: (FamixPWBBasicType named: 'string');
		mooseModel: testModel.
	variable := MrlnstanceVariable new
		instance_variable_pwb_object: 'uo_test';
		instance_variable_name: 'testInstvar'.
	acc := MrlInstanceVariableAccess new variable: variable.
	mrlBehavior addMrlInstanceVariablesAccess: acc.
	testEventGenerator
		instanceVariableInitializationTimestamp: '0'
		on: stream.
	mrlBehavior mrlBehaviorDatas: nil.
	self assert: self script equals: ''.
	acc
		mooseModel: testModel;
		instance_variable_access_timestamp: '0';
		beforeValue: (MrlVariableAccessBeforeValue new mrlvalue: 'aloba').
	testEventGenerator
		instanceVariableInitializationTimestamp: '0'
		on: stream.
	self
		assert: self script
		equals:
			'luo_test.testInstvar = "aloba"
'
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
	| param |
	param := MrlParameter new.
	mrlBehavior addMrlParameter: param.
	testEventGenerator parameterInitializationTimestamp: '0' on: stream.
	self assert: self script equals: ''.
	param timestamp: '0'.
	mrlBehavior mrlBehaviorDatas: nil.
	param
		originalParameter: testParam1;
		parameter_name: 'testParam1';
		parameter_before_value: (MrlParameter_before_value new parameter_value: 'aloba').
	testEventGenerator parameterInitializationTimestamp: '0' on: stream.
	self
		assert: self script
		equals:
			'lestParam1 = "aloba"
'
]

{ #category : #tests }
PWBTestEventGeneratorTest >> testReturnAssertTimestamp [
	mrlBehavior addMrlReturnValue: MrlReturnValue new.
	testEventGenerator returnAssertTimestamp: '0' on: stream.
	self assert: self script isEmpty.
	mrlBehavior mrlBehaviorDatas: nil.
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
