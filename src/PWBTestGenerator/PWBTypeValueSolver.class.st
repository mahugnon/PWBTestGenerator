Class {
	#name : #PWBTypeValueSolver,
	#superclass : #Object,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
PWBTypeValueSolver class >> accept: aTypeName [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBTypeValueSolver class >> handleNilValue: aString [
	^ NilValueSolver new resolve: aString
]

{ #category : #'as yet unclassified' }
PWBTypeValueSolver class >> resolveValue: aString withType: aTypeName [
	^ aString
		ifNotNil: [ (self subclasses detect: [ :sub | sub accept: aTypeName ]) new
				resolve: aString ]
		ifNil: [ self handleNilValue: aString ]
]

{ #category : #resolving }
PWBTypeValueSolver >> resolve: aString [
	
]
