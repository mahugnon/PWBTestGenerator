Class {
	#name : #TaskListAccessStrategy,
	#superclass : #TaskListStrategy,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #'as yet unclassified' }
TaskListAccessStrategy class >> accept: aMrlBehavior [
	^ aMrlBehavior pwbParameters isEmpty
		and: [ aMrlBehavior mrlInstanceVariablesAccesses isNotEmpty ]
]

{ #category : #applying }
TaskListAccessStrategy >> applyOn: aMrlBehavior [
	^ aMrlBehavior createTaskWithAccessStrategy
]
