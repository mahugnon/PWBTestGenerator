Class {
	#name : #PWBTypeSolverTest,
	#superclass : #TestCase,
	#instVars : [
		'testFunction',
		'testModel',
		'stream'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #accessing }
PWBTypeSolverTest >> script [
	^ stream contents copyReplaceAll: String crlf with: String cr
]

{ #category : #running }
PWBTypeSolverTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	stream := WriteStream on: String new
]

{ #category : #tests }
PWBTypeSolverTest >> testAnyValueVariableInitializerRightSideOn [
	| mrlParameter |
	mrlParameter := MrlParameter new
		parameter_before_value: (MrlParameter_before_value new parameter_value: 'aloba').
	AnyValueVariableInitializer new
		focus: mrlParameter;
		rightSideOn: stream.
	self assert: self script equals: '"aloba"
'
]

{ #category : #tests }
PWBTypeSolverTest >> testBooleanVariableInitializerRightSideOn [
	| mrlParameter |
	mrlParameter := MrlParameter new
		parameter_before_value: (MrlParameter_before_value new parameter_value: 'true').
	BooleanVariableInitializer new
		focus: mrlParameter;
		rightSideOn: stream.
	self
		assert: self script
		equals:
			'true
'
]

{ #category : #tests }
PWBTypeSolverTest >> testDataStoreVariableInitializerRightSideOn [
	| mrlParameter |
	mrlParameter := MrlParameter new
		parameter_before_value: (MrlParameter_before_value new parameter_value: 'true').
	DataStoreVariableInitializer new
		focus: mrlParameter;
		rightSideOn: stream.
	self assert: self script isEmpty
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueBooleanSolver [
	self
		assert: (PWBVariableInitializer printValue: 'true' ofType: 'boolean')
		equals: 'true'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueDateSolver [
	self
		assert: (PWBVariableInitializer printValue: '06/01/2020' ofType: 'date')
		equals: 'date("06/01/2020")'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueNumberSolver [
	self
		assert: (PWBVariableInitializer printValue: '2.5' ofType: 'double')
		equals: '2.5'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueStringSolver [
	self
		assert: (PWBVariableInitializer printValue: 'hello' ofType: 'string')
		equals: '"hello"'
]
