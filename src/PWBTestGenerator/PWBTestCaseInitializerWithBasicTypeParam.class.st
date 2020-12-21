Class {
	#name : #PWBTestCaseInitializerWithBasicTypeParam,
	#superclass : #PWBTestCaseInitializer,
	#category : #'PWBTestGenerator-Assertions'
}

{ #category : #visiting }
PWBTestCaseInitializerWithBasicTypeParam class >> accept: aCollection [
	^ aCollection allSatisfy: [ :e | e isPWBDataWindow not ]
]
