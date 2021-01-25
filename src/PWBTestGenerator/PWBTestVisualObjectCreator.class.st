Class {
	#name : #PWBTestVisualObjectCreator,
	#superclass : #PWBTestObjectCreator,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #'as yet unclassified' }
PWBTestVisualObjectCreator class >> accept: aString [
	^ {'w_'} anySatisfy: [ :each | aString asLowercase beginsWith: each ]
]

{ #category : #initialization }
PWBTestVisualObjectCreator >> objectNamed: anObjectName on: aStream [
	| varName |
	varName := 'l' , anObjectName.
	aStream
		<< anObjectName;
		space;
		<< varName;
		crlf;
		<< 'open(';
		<< varName;
		<< ')';
		crlf;
		<< varName;
		<< '.hide()';
		crlf
]
