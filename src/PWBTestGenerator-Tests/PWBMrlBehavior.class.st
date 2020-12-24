Class {
	#name : #PWBMrlBehavior,
	#superclass : #PWBAbstractTestGenerationTest,
	#instVars : [
		'testMrlBehavior'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #running }
PWBMrlBehavior >> setUp [
	super setUp.
	testMrlBehavior := MrlBehavior new behaviorUnderTest: testFunction
]

{ #category : #'as yet unclassified' }
PWBMrlBehavior >> testCreateAssertionsFromDataIfAccessIsEmpty [
	| testParam timestamp |
	timestamp := Date today asString.
	testParam := FamixPWBParameter new
		name: 'param1';
		parameterType: (FamixPWBBasicType new name: 'string');
		mooseModel: testModel;
		behavioral: testFunction.
	testMrlBehavior
		addMrlReturnValue:
			(MrlReturnValue new
				timestamp: timestamp;
				mrlValue: '6').
	testMrlBehavior
		addMrlParameter:
			(MrlParameter new
				parameter_name: 'param1';
				timestamp: timestamp;
				originalParameter: testParam).
	self assert: testMrlBehavior createSteps size equals: 3
]

{ #category : #'as yet unclassified' }
PWBMrlBehavior >> testCreateAssertionsFromDataIfReturnValuesIsEmptyButAccessIsNot [
	testMrlBehavior
		addMrlInstanceVariablesAccess: MrlInstanceVariableAccess new.
	self assert: testMrlBehavior createSteps size equals: 3
]

{ #category : #'as yet unclassified' }
PWBMrlBehavior >> testCreateAssertionsFromDataNoParamNoAccess [
	| task taskList |
	testMrlBehavior addMrlReturnValue: MrlReturnValue new.
	taskList := testMrlBehavior createSteps.
	task := taskList detect: [ :e | e isReturnBasedAssertion ].
	self assert: taskList size equals: 3.
	self assert: task isNotNil
]

{ #category : #'as yet unclassified' }
PWBMrlBehavior >> testCreateTaskIfParametersIsEmptyAndAccessAswell [
	self assert: testMrlBehavior createSteps isEmpty
]
