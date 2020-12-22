Class {
	#name : #PWBReturnBasedUnitAssertionDataWindowParam,
	#superclass : #PWBAbstractReturnBaseUnitAssertion,
	#category : #'PWBTestGenerator-Task'
}

{ #category : #'as yet unclassified' }
PWBReturnBasedUnitAssertionDataWindowParam class >> accept: aCollection [
	^ aCollection anySatisfy: #isPWBDataWindow
]
