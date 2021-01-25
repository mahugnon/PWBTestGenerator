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
