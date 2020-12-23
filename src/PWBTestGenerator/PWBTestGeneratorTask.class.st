Class {
	#name : #PWBTestGeneratorTask,
	#superclass : #Object,
	#instVars : [
		'timestamp'
	],
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

{ #category : #asserting }
PWBTestGeneratorTask >> shouldExecuteBefore: aPWBTestGeneratorTask [
	^ self timestamp <= aPWBTestGeneratorTask timestamp
		and: [ self priority < aPWBTestGeneratorTask priority ]
]

{ #category : #asserting }
PWBTestGeneratorTask >> timestamp [
	^ timestamp
]

{ #category : #asserting }
PWBTestGeneratorTask >> timestamp: aString [
	timestamp := aString
]
