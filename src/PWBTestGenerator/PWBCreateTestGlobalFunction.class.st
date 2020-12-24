Class {
	#name : #PWBCreateTestGlobalFunction,
	#superclass : #PWBCreateTestObjectTask,
	#category : #'PWBTestGenerator-Task'
}

{ #category : #'as yet unclassified' }
PWBCreateTestGlobalFunction class >> accept: aString [
	^ aString asLowercase beginsWith: 'f_'
]

{ #category : #'as yet unclassified' }
PWBCreateTestGlobalFunction >> createAndInitialize: aString on: aStream [
	^ aStream
]
