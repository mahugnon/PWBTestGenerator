Class {
	#name : #PWBReturnBasedUnitAssertionWithBasicTypeParam,
	#superclass : #PWBAbstractReturnBaseUnitAssertion,
	#category : #'PWBTestGenerator-Assertions'
}

{ #category : #'as yet unclassified' }
PWBReturnBasedUnitAssertionWithBasicTypeParam class >> accept: aCollection [
	^ aCollection allSatisfy: [ :e | e isPWBDataWindow not ]
]

{ #category : #printing }
PWBReturnBasedUnitAssertionWithBasicTypeParam >> printPWBScriptOn: stream [
	self printParametersInitializationOn: stream.
	self printFunctionInvocationScriptOn: stream.
	self printAccessAssertionOn: stream.
	self printReturnAssertionOn: stream.
	^ stream
]

{ #category : #printing }
PWBReturnBasedUnitAssertionWithBasicTypeParam >> printParametersInitializationOn: stream [
	self pwbParameters
		do:
			[ :param | PWBVariableInitializer printParameter: param on: stream ]
]
