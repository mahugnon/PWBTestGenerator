Class {
	#name : #PWBTestNonVisualObjectCreator,
	#superclass : #PWBTestObjectCreator,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #'as yet unclassified' }
PWBTestNonVisualObjectCreator class >> accept: aString [
	^ {'uo_'}
		anySatisfy: [ :each | aString asLowercase beginsWith: each ]
]

{ #category : #'as yet unclassified' }
PWBTestNonVisualObjectCreator >> initialize: aString on: aStream [
	^ aStream
		<< varName;
		space;
		<< '=';
		space;
		<< 'create';
		space;
		<< aString;
		crlf
]
