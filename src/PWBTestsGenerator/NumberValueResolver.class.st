Class {
	#name : #NumberValueResolver,
	#superclass : #PWBTypeValueResolver,
	#category : #'PWBTestsGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
NumberValueResolver class >> accept: aTypeName [
	^ #('Integer' 'Decimal' 'Int' 'Double' 'Number' 'Long')
		anySatisfy: [ :type | type asLowercase = aTypeName asLowercase ]
]

{ #category : #resolving }
NumberValueResolver >> resolve: aString [
	^ aString ifNil: [ 'SetNull(' , aString asString , ')' ] ifNotNil: [ aString ]
]
