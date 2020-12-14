Class {
	#name : #PWBUnitTestForFunctionWithDataStoreArgument,
	#superclass : #PWBUnitTestForFunctionWithBasicTypeArguments,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #visiting }
PWBUnitTestForFunctionWithDataStoreArgument class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isNotEmpty
		and: [ aFamixPWBFunction parameters
				anySatisfy: [ :param | param name asLowercase beginsWith: 'ds_' ] ]
]
