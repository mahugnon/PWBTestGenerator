Class {
	#name : #PWBTestGeneratorTask,
	#superclass : #Object,
	#category : #'PWBTestGenerator-Task'
}

{ #category : #testing }
PWBTestGeneratorTask >> isAccessBasedAssertion [
	^ false
]

{ #category : #testing }
PWBTestGeneratorTask >> isBehaviorInvocation [
	^ false
]

{ #category : #testing }
PWBTestGeneratorTask >> isReturnBasedAssertion [
	^ false
]

{ #category : #testing }
PWBTestGeneratorTask >> isTestCaseInitializer [
	^ false
]

{ #category : #accessing }
PWBTestGeneratorTask >> priority [
	self subclassResponsibility
]
