Class {
	#name : #PWBTestUserObjectCreator,
	#superclass : #PWBTestObjectCreator,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #'as yet unclassified' }
PWBTestUserObjectCreator class >> accept: aString [
	^ aString asLowercase beginsWith: 'uo_'
]

{ #category : #'as yet unclassified' }
PWBTestUserObjectCreator >> objectNamed: anObjectName on: aStream [
	| varName |
	varName := 'l' , anObjectName.
	aStream
		<< anObjectName;
		space;
		<< varName;
		crlf;
		<< 'w_app_mdi.openUserObject(';
		<< varName;
		nextPut: $);
		crlf
]
