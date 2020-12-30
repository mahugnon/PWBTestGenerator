Class {
	#name : #PWBTestInstanceVariableAssertCreator,
	#superclass : #Object,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #'as yet unclassified' }
PWBTestInstanceVariableAssertCreator class >> accept:  anAccess [
self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PWBTestInstanceVariableAssertCreator class >> access: aMrlInstanceVariableAccess on: stream [
	(self subclasses
		detect: [ :sub | sub accept: aMrlInstanceVariableAccess ]) new
		access: aMrlInstanceVariableAccess
		on: stream
]

{ #category : #'as yet unclassified' }
PWBTestInstanceVariableAssertCreator >> access: aMrlInstanceVariableAccess on: stream [
self subclassResponsibility 
]
