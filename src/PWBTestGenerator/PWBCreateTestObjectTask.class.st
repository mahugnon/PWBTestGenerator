Class {
	#name : #PWBCreateTestObjectTask,
	#superclass : #PWBTestGeneratorTask,
	#instVars : [
		'varName'
	],
	#category : #'PWBTestGenerator-Task'
}

{ #category : #'as yet unclassified' }
PWBCreateTestObjectTask class >> accept: aString [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBCreateTestObjectTask class >> createAndInitialize: aString on: aStream [
	^ (self subclasses detect: [ :sub | sub accept: aString ]) new
		createAndInitialize: aString
		on: aStream
]

{ #category : #'as yet unclassified' }
PWBCreateTestObjectTask >> create: aString On: aStream [
	^ aStream
		<< aString;
		space;
		<< varName;
		crlf
]

{ #category : #'as yet unclassified' }
PWBCreateTestObjectTask >> createAndInitialize: aString on: aStream [
	varName := 'l' , aString.
	^ self initialize: aString on: (self create: aString On: aStream)
]

{ #category : #initialization }
PWBCreateTestObjectTask >> initialize: aString on: aStream [
	self subclassResponsibility
]
