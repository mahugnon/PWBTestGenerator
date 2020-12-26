Class {
	#name : #PWBTestObjectCreator,
	#superclass : #Object,
	#instVars : [
		'varName'
	],
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #'as yet unclassified' }
PWBTestObjectCreator class >> accept: aString [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBTestObjectCreator class >> createAndInitialize: aString on: aStream [
	^ (self subclasses detect: [ :sub | sub accept: aString ]) new
		createAndInitialize: aString
		on: aStream
]

{ #category : #'as yet unclassified' }
PWBTestObjectCreator >> create: aString On: aStream [
	^ aStream
		<< aString;
		space;
		<< varName;
		crlf
]

{ #category : #'as yet unclassified' }
PWBTestObjectCreator >> createAndInitialize: aString on: aStream [
	(aString beginsWith: 'f_')
		ifTrue: [ ^ aStream ].
	varName := 'l' , aString.
	^ self initialize: aString on: (self create: aString On: aStream)
]

{ #category : #initialization }
PWBTestObjectCreator >> initialize: aString on: aStream [
	self subclassResponsibility
]
