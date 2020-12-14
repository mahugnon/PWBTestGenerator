Class {
	#name : #PWBTestAssertionTest,
	#superclass : #PWBAbstractTestGenerationTest,
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #tests }
PWBTestAssertionTest >> testAttributeAccessedIsBasicAndBelongToSameObjectAssertion [
	| script mockAtt testAttribute |
	testAttribute := FamixPWBInstanceVariable new
		mooseModel: testModel;
		name: 'testAttribute';
		attributeType: (FamixPWBBasicType new name: 'string');
		parentType: testObject.
	FamixPWBAccess new
		source: testFunction;
		target: testAttribute.
	mockAtt := Mock named: 'testAttribute'.
	mockAtt stub beforeValue willReturn: 'before'.
	mockAtt stub afterValue willReturn: 'after'.
	script := String
		streamContents: [ :stream | 
			PWBFunctionWithBasicTypesParametersUnitAssertion new
				printAccessAssertionOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'this.assert(after = this.testAttribute)
'
]

{ #category : #tests }
PWBTestAssertionTest >> testAttributeAccessedIsBasicAndBelongTodifferentObjectAssertion [
	| script mockAtt testAttribute |
	testAttribute := FamixPWBInstanceVariable new
		mooseModel: testModel;
		name: 'testAttribute';
		attributeType: (FamixPWBBasicType new name: 'string');
		parentType: testObject.
	FamixPWBAccess new
		source: testFunction;
		target: testAttribute.
	mockAtt := Mock named: 'testAttribute'.
	mockAtt stub beforeValue willReturn: 'before'.
	mockAtt stub afterValue willReturn: 'after'.
	script := String
		streamContents: [ :stream | 
			PWBFunctionWithBasicTypesParametersUnitAssertion new
				printAccessAssertionOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'this.assert(after = ltestobject.testAttribute)
'
]

{ #category : #tests }
PWBTestAssertionTest >> testInitializeAccess [
	| script mockAtt testAttribute |
	testAttribute := FamixPWBAttribute new
		name: 'testAttribute';
		parentType: testObject;
		mooseModel: testModel.
	FamixPWBAccess new
		source: testFunction;
		target: testAttribute.
	mockAtt := Mock named: 'testAttribute'.
	mockAtt stub beforeValue willReturn: 'before'.
	script := String
		streamContents: [ :stream | 
			PWBFunctionWithBasicTypesParametersUnitAssertion new
				functionUnderTest: testFunction;
				printAccesInitializationOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'this.assert(after = ltestobject.testAttribute)
'
]
