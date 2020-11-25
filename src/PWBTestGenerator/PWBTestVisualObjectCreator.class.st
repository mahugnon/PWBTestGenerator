Class {
	#name : #PWBTestVisualObjectCreator,
	#superclass : #PWBTestObjectCreator,
	#category : #'PWBTestGenerator-PWBTestUnit'
}

{ #category : #'as yet unclassified' }
PWBTestVisualObjectCreator class >> accept: aString [
	^ {'w_'} anySatisfy: [ :each | aString asLowercase beginsWith: each ]
]

{ #category : #initialization }
PWBTestVisualObjectCreator >> initialize: aString on: aStream [
	^ aStream
		<< 'open(';
		<< varName;
		<< ')';
		crlf;
		<< varName;
		<< '.hide()';
		crlf
]