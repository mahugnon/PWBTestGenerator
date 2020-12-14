Class {
	#name : #PWBTestAssertionTest,
	#superclass : #PWBAbstractTestGenerationTest,
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #tests }
PWBTestAssertionTest >> testAttributeAccessedIsBasicTypeAssertion [
	| script mockAcc1 mockAcc2 |
	mockAcc1 := Mock named: 'testAttribute1'.
	mockAcc1 stub variableName willReturn: 'testAttribute1'.
	mockAcc1 stub pwb_object willReturn: 'testObject'.
	mockAcc1 stub variableTypeName willReturn: 'string'.
	mockAcc1 stub afterValue willReturn: 'after2'.
	mockAcc2 := Mock named: 'testAttribute2'.
	mockAcc2 stub variableName willReturn: 'testAttribute2'.
	mockAcc2 stub pwb_object willReturn: 'testObject'.
	mockAcc2 stub variableTypeName willReturn: 'integer'.
	mockAcc2 stub afterValue willReturn: 'after2'.
	script := String
		streamContents: [ :stream | 
			PWBFunctionWithBasicTypesParametersUnitAssertion new
				addAccess: mockAcc1;
				addAccess: mockAcc2;
				printAccessAssertionOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'this.assert(after2=ltestObject.testAttribute1)
this.assert(after2=ltestObject.testAttribute2)
'
]

{ #category : #tests }
PWBTestAssertionTest >> testInitializeAccess [
	| script mockAcc1 mockAcc2 |
	mockAcc1 := Mock named: 'testAttribute1'.
	mockAcc1 stub variableName willReturn: 'testAttribute1'.
	mockAcc1 stub pwb_object willReturn: 'testObject'.
	mockAcc1 stub variableTypeName willReturn: 'string'.
	mockAcc1 stub beforeValue willReturn: 'before1'.
	mockAcc2 := Mock named: 'testAttribute2'.
	mockAcc2 stub variableName willReturn: 'testAttribute2'.
	mockAcc2 stub pwb_object willReturn: 'testObject'.
	mockAcc2 stub variableTypeName willReturn: 'integer'.
	mockAcc2 stub beforeValue willReturn: 'before2'.
	script := String
		streamContents: [ :stream | 
			PWBFunctionWithBasicTypesParametersUnitAssertion new
				addAccess: mockAcc1;
				addAccess: mockAcc2;
				functionUnderTest: testFunction;
				printAccesInitializationOn: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'ltestObject.testAttribute1 = "before1"
ltestObject.testAttribute2 = before2
'
]
