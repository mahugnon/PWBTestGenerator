Class {
	#name : #PWBTestNonVisualObjectCreator,
	#superclass : #PWBTestObjectCreator,
	#category : #'PWBTestsGenerator-PWBTestUnitStrategy'
}

{ #category : #'as yet unclassified' }
PWBTestNonVisualObjectCreator class >> accept: aString [
	^ {'uo_'}
		anySatisfy: [ :each | aString asLowercase beginsWith: each ]
]

{ #category : #'as yet unclassified' }
PWBTestNonVisualObjectCreator >> initialize: aString On: aStream [
	^ aStream
		<< varName;
		space;
		<< '=';
		space;
		<< 'create';
		space;
		<< aStream;
		crlf
]
