Class {
	#name : #PWBTestAssertionTest,
	#superclass : #PWBAbstractTestGenerationTest,
	#instVars : [
		'testAcc1',
		'testAcc2',
		'access1'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #tests }
PWBTestAssertionTest >> createAccesses [
	access1 := MrlInstanceVariableAccess new.
	access1
		mooseModel: testModel;
		beforeValue: (MrlVariableAccessBeforeValue new mrlvalue: 'before1');
		afterValue: (MrlVariableAccessAfterValue new mrlvalue: 'after1').
	access1
		instance_variable_access_accessed:
			(MrlnstanceVariable new
				instance_variable_pwb_object: 'testObject';
				instance_variable_name: 'testAttribute1')
]

{ #category : #'as yet unclassified' }
PWBTestAssertionTest >> createTestVariables [
	FamixPWBInstanceVariable new
		mooseModel: testModel;
		parentType: testObject;
		name: 'testAttribute1';
		attributeType: (FamixPWBBasicType new name: 'string')
]

{ #category : #running }
PWBTestAssertionTest >> setUp [
	super setUp.
	self createTestVariables.
	self createAccesses
]

{ #category : #tests }
PWBTestAssertionTest >> testAttributeAccessedIsBasicTypeAssertion [
	| script |
	script := String
		streamContents: [ :stream | 
			PWBFunctionWithBasicTypesParametersUnitAssertion new
				functionUnderTest: testFunction;
				addAccess: access1;
				printAccessAssertionOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'this.assert(after1=ltestObject.testAttribute1)
'
]

{ #category : #tests }
PWBTestAssertionTest >> testInitializeAccess [
	| script |
	self createAccesses.
	script := String
		streamContents: [ :stream | 
			PWBFunctionWithBasicTypesParametersUnitAssertion new
				functionUnderTest: testFunction;
				addAccess: access1;
				printAccesInitializationOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'ltestObject.testAttribute1 = "before1"
'
]
