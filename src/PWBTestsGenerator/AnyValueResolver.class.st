Class {
	#name : #AnyValueResolver,
	#superclass : #PWBTypeValueResolver,
	#category : #'PWBTestsGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
AnyValueResolver class >> accept: aTypeName [
	^ aTypeName asLowercase = 'any'
]

{ #category : #resolving }
AnyValueResolver >> resolve: aString [
	^ aString
]
