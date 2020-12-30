Class {
	#name : #PWBTestGlobalFunctionObjectCreator,
	#superclass : #PWBTestObjectCreator,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #'as yet unclassified' }
PWBTestGlobalFunctionObjectCreator class >> accept: aString [
	^ aString asLowercase beginsWith: 'f_'
]

{ #category : #'as yet unclassified' }
PWBTestGlobalFunctionObjectCreator >> objectNamed: anObjectName on: aStream [
	"do nothing"

	
]
