Class {
	#name : #PWBAbstractTestGenerationTest,
	#superclass : #TestCase,
	#instVars : [
		'testFunction',
		'testModel',
		'testObject',
		'access1'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #tests }
PWBAbstractTestGenerationTest >> createAccesses [
	access1 := MrlInstanceVariableAccess new.
	access1
		mooseModel: testModel;
		instance_variable_access_timestamp: '6';
		beforeValue: (MrlVariableAccessBeforeValue new mrlvalue: 'before1');
		afterValue: (MrlVariableAccessAfterValue new mrlvalue: 'after1').
	access1
		variable:
			(MrlnstanceVariable new
				instance_variable_pwb_object: 'uo_testObject';
				instance_variable_name: 'testAttribute1')
]

{ #category : #'as yet unclassified' }
PWBAbstractTestGenerationTest >> createTestVariables [
	FamixPWBInstanceVariable new
		mooseModel: testModel;
		parentType: testObject;
		name: 'testAttribute1';
		attributeType: (FamixPWBBasicType new name: 'string')
]

{ #category : #running }
PWBAbstractTestGenerationTest >> setUp [
	testModel := FamixPWBModel new.
	testObject := FamixPWBUserObject new
		name: 'uo_testObject';
		mooseModel: testModel.
	testFunction := FamixPWBFunction new
		name: 'testFunction';
		parentType: testObject;
		accessModifier: 'public';
		mooseModel: testModel.
	PharoDatabaseAccessor DefaultDriver isNil
		ifNil: [ PharoDatabaseAccessor DefaultDriver: P3DatabaseDriver ]
]

{ #category : #tests }
PWBAbstractTestGenerationTest >> testParameterDataObject [
	| param |
	param := MrlParameter new
		parameter_before_value:
			(MrlParameter_before_value new
				parameter_dataobject: 'before_dataobject');
		parameter_after_value:
			(MrlParameter_after_value new parameter_dataobject: 'after_dataobject').
	self
		assert: (param parameter_dataobjectForTag: 'before')
		equals: 'before_dataobject'.
	self
		assert: (param parameter_dataobjectForTag: 'after')
		equals: 'after_dataobject'
]
