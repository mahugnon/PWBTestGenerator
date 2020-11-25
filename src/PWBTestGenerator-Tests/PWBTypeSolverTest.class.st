Class {
	#name : #PWBTypeSolverTest,
	#superclass : #TestCase,
	#instVars : [
		'testFunction',
		'testModel'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueBooleanSolver [
	self
		assert: (PWBTypeValueSolver resolveValue: 'true' withType: 'boolean')
		equals: 'true'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueDateSolver [
	self
		assert: (PWBTypeValueSolver resolveValue: '06/01/2020' withType: 'date')
		equals: 'date("06/01/2020")'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueNilSolver [
	self
		assert: (PWBTypeValueSolver resolveValue: nil  withType: 'string')
		equals: 'SetNull(nil)'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueNumberSolver [
	self
		assert: (PWBTypeValueSolver resolveValue: '2.5' withType: 'double')
		equals: '2.5'.
	
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueStringSolver [
	self
		assert: (PWBTypeValueSolver resolveValue: 'hello' withType: 'string')
		equals: '"hello"'
]
