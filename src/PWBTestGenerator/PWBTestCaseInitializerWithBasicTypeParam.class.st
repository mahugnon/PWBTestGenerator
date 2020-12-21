Class {
	#name : #PWBTestCaseInitializerWithBasicTypeParam,
	#superclass : #PWBTestCaseInitializer,
	#category : #'PWBTestGenerator-Task'
}

{ #category : #visiting }
PWBTestCaseInitializerWithBasicTypeParam class >> accept: aCollection [
	^ aCollection allSatisfy: [ :e | e isPWBDataWindow not ]
]
