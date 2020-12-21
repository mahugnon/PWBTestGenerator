Class {
	#name : #PWBReturnBasedUnitAssertionWithBasicTypeParam,
	#superclass : #PWBAbstractReturnBaseUnitAssertion,
	#category : #'PWBTestGenerator-Task'
}

{ #category : #'as yet unclassified' }
PWBReturnBasedUnitAssertionWithBasicTypeParam class >> accept: aCollection [
	^ aCollection allSatisfy: [ :e | e isPWBDataWindow not ]
]

{ #category : #printing }
PWBReturnBasedUnitAssertionWithBasicTypeParam >> printPWBScriptOn: stream [
	self printReturnAssertionOn: stream.
	^ stream
]

{ #category : #printing }
PWBReturnBasedUnitAssertionWithBasicTypeParam >> printParametersInitializationOn: stream [
	self pwbParameters
		do:
			[ :param | PWBVariableInitializer printParameter: param on: stream ]
]
