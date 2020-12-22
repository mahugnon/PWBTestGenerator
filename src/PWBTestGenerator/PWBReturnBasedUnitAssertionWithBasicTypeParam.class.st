Class {
	#name : #PWBReturnBasedUnitAssertionWithBasicTypeParam,
	#superclass : #PWBAbstractReturnBaseUnitAssertion,
	#category : #'PWBTestGenerator-Task'
}

{ #category : #'as yet unclassified' }
PWBReturnBasedUnitAssertionWithBasicTypeParam class >> accept: aCollection [
	^ aCollection allSatisfy: [ :e | e isPWBDataWindow not ]
]
