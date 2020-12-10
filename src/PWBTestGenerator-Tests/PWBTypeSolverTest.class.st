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
		assert: (PWBTypeValueSolver printValue: 'true' ofType: 'boolean')
		equals: 'true'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueDateSolver [
	self
		assert: (PWBTypeValueSolver printValue: '06/01/2020' ofType: 'date')
		equals: 'date("06/01/2020")'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueNumberSolver [
	self
		assert: (PWBTypeValueSolver printValue: '2.5' ofType: 'double')
		equals: '2.5'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueStringSolver [
	self
		assert: (PWBTypeValueSolver printValue: 'hello' ofType: 'string')
		equals: '"hello"'
]
