Class {
	#name : #PWBTestVisualObjectCreator,
	#superclass : #PWBTestObjectCreator,
	#category : #'PWBTestsGenerator-PWBTestUnitStrategy'
}

{ #category : #'as yet unclassified' }
PWBTestVisualObjectCreator class >> accept: aString [
	^ {'w_'} anySatisfy: [ :each | aString asLowercase beginsWith: each ]
]

{ #category : #initialization }
PWBTestVisualObjectCreator >> initialize: aString On: aStream [
	^ aStream
		<< varName;
		<< '.hide()';
		crlf;
		<< 'open(';
		<< varName;
		<< ')';
		crlf
]
