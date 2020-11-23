Class {
	#name : #PWBTestObjectCreator,
	#superclass : #Object,
	#instVars : [
		'varName'
	],
	#category : #'PWBTestsGenerator-PWBTestUnitStrategy'
}

{ #category : #'as yet unclassified' }
PWBTestObjectCreator class >> accept: aString [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBTestObjectCreator class >> createAndInitialize: aString On: aStream [
	^ (self subclasses detect: [ :sub | sub accept: aString ]) new
		createAndInitialize: aString
		On: aStream
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
PWBTestObjectCreator >> createAndInitialize: aString On: aStream [
	varName := 'l_' , aString.
	^ self initialize: aString On: (self create: aString On: aStream)
]

{ #category : #initialization }
PWBTestObjectCreator >> initialize: aString On: aStream [
	self subclassResponsibility
]
