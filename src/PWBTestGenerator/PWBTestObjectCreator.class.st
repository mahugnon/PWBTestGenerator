Class {
	#name : #PWBTestObjectCreator,
	#superclass : #Object,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #initialization }
PWBTestObjectCreator class >> accept: aString [
	^ self subclassResponsibility
]

{ #category : #initialization }
PWBTestObjectCreator class >> objectNamed: aString on: aStream [
	^ (self subclasses detect: [ :sub | sub accept: aString ]) new
		objectNamed: aString
		on: aStream
]

{ #category : #initialization }
PWBTestObjectCreator >> objectNamed: anObjectName on: aStream [
	self subclassResponsibility
]
