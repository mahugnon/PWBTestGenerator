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
