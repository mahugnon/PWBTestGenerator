Class {
	#name : #StringValueResolver,
	#superclass : #PWBTypeValueResolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
StringValueResolver class >> accept: aTypeName [
	^ aTypeName asLowercase ='string'
]

{ #category : #resolving }
StringValueResolver >> resolve: aString [
	^ aString ifNil: [ '""' ] ifNotNil: [ '"' , aString , '"' ]
]
