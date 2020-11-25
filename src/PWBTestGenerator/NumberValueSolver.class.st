Class {
	#name : #NumberValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
NumberValueSolver class >> accept: aTypeName [
	^ #('Integer' 'Decimal' 'Int' 'Double' 'Number' 'Long')
		anySatisfy: [ :type | type asLowercase = aTypeName asLowercase ]
]

{ #category : #resolving }
NumberValueSolver >> resolve: aString [
	^ aString ifNotNil: [ aString ]
]
