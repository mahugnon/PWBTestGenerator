Class {
	#name : #PWBTestInstanceVariableAssertCreatorTest,
	#superclass : #TestCase,
	#instVars : [
		'stream',
		'testModel',
		'uo_test'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #accessing }
PWBTestInstanceVariableAssertCreatorTest >> script [
	^ stream contents copyReplaceAll: String crlf with: String cr
]

{ #category : #running }
PWBTestInstanceVariableAssertCreatorTest >> setUp [
	testModel := FamixPWBModel new.
	uo_test := FamixPWBUserObject new
		name: 'uo_test';
		mooseModel: testModel.
	stream := WriteStream on: String new
]

{ #category : #accessing }
PWBTestInstanceVariableAssertCreatorTest >> testPWBTestBasicTypeInstanceVariableAssertCreatorAccessOn [
	| acc variable |
	FamixPWBInstanceVariable new
		name: 'testInstvar';
		parentType: uo_test;
		attributeType: (FamixPWBBasicType named: 'string');
		mooseModel: testModel.
	variable := MrlnstanceVariable new
		instance_variable_pwb_object: 'uo_test';
		instance_variable_name: 'testInstvar'.
	acc := MrlInstanceVariableAccess new
		variable: variable;
		afterValue: (MrlVariableAccessBeforeValue new mrlvalue: 'aloba');
		mooseModel: testModel.
	PWBTestBasicTypeInstanceVariableAssertCreator new
		access: acc
		on: stream.
	self
		assert: self script
		equals:
			'this.assert("aloba" =luo_test.testInstvar)
'
]
