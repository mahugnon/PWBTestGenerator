Class {
	#name : #PWBFunctionWithDataStoreArgumentUnitTest,
	#superclass : #PWBFunctionWithBasicTypeArgumentsUnitTest,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #visiting }
PWBFunctionWithDataStoreArgumentUnitTest class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isNotEmpty
		and: [ aFamixPWBFunction parameters
				anySatisfy: [ :param | param name asLowercase beginsWith: 'ds_' ] ]
]
