Class {
	#name : #PWBTestGeneratorTask,
	#superclass : #Object,
	#instVars : [
		'time'
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
	^ self time < aPWBTestGeneratorTask time
		or: [ self time = aPWBTestGeneratorTask time
				and: [ self priority < aPWBTestGeneratorTask priority ] ]
]

{ #category : #accessing }
PWBTestGeneratorTask >> time [
	^ time
]

{ #category : #accessing }
PWBTestGeneratorTask >> time: anObject [
	time := anObject
]
