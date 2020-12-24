Class {
	#name : #PWBBehaviorWithDataStoreArgumentTestMethod,
	#superclass : #PWBBehaviorWithBasicTypeArgumentsTestMethod,
	#category : #'PWBTestGenerator-PWBTestSuite'
}

{ #category : #visiting }
PWBBehaviorWithDataStoreArgumentTestMethod class >> acceptFunction: aFamixPWBFunction [
	^ aFamixPWBFunction parameters isNotEmpty
		and: [ aFamixPWBFunction parameters
				anySatisfy: [ :param | param name asLowercase beginsWith: 'ds_' ] ]
]
