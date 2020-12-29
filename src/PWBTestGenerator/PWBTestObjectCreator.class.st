Class {
	#name : #PWBTestObjectCreator,
	#superclass : #Object,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #'as yet unclassified' }
PWBTestObjectCreator class >> accept: aString [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBTestObjectCreator class >> objectNamed: aString on: aStream [
	^ (self subclasses detect: [ :sub | sub accept: aString ]) new
		objectNamed: aString
		on: aStream
]

{ #category : #'as yet unclassified' }
PWBTestObjectCreator >> objectNamed: anObjectName on: aStream [
	self subclassResponsibility
]
