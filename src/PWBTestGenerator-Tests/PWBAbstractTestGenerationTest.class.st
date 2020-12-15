Class {
	#name : #PWBAbstractTestGenerationTest,
	#superclass : #TestCase,
	#instVars : [
		'testFunction',
		'testModel',
		'testObject'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #running }
PWBAbstractTestGenerationTest >> setUp [
	testModel := FamixPWBModel new.
	testObject := FamixPWBUserObject new
		name: 'testObject';
		mooseModel: testModel.
	testFunction := FamixPWBFunction new
		name: 'testFunction';
		parentType: testObject;
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
