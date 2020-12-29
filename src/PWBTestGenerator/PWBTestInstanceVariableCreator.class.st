Class {
	#name : #PWBTestInstanceVariableCreator,
	#superclass : #Object,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #visiting }
PWBTestInstanceVariableCreator class >> accept: anAccess [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBTestInstanceVariableCreator class >> access: acc on: stream [
	(self subclasses detect: [ :sub | sub accept: acc ]) new
		access: acc
		on: stream
]

{ #category : #'as yet unclassified' }
PWBTestInstanceVariableCreator >> access: acc on: stream [
	self subclassResponsibility
]
