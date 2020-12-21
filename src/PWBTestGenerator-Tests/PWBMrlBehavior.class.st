Class {
	#name : #PWBMrlBehavior,
	#superclass : #PWBAbstractTestGenerationTest,
	#instVars : [
		'testMrlBehavior'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #'as yet unclassified' }
PWBMrlBehavior >> createAssertionsFromDataIfAccessIsEmpty [
]

{ #category : #running }
PWBMrlBehavior >> setUp [
	super setUp.
	testMrlBehavior := MrlBehavior new
]

{ #category : #'as yet unclassified' }
PWBMrlBehavior >> testCreateAssertionsFromDataIfParametersIsEmpty [
]

{ #category : #'as yet unclassified' }
PWBMrlBehavior >> testCreateAssertionsFromDataIfReturnValuesIsEmptyButAccessIsNot [
	testMrlBehavior
		addMrlParameter: (MrlParameter new parameter_name: 'param1').
	self assert: testMrlBehavior createAssertionsFromData size equals: 1
]
