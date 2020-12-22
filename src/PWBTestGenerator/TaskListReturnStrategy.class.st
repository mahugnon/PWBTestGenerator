Class {
	#name : #TaskListReturnStrategy,
	#superclass : #TaskListStrategy,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #'as yet unclassified' }
TaskListReturnStrategy class >> accept: aMrlBehavior [
	^ aMrlBehavior pwbParameters isEmpty
		and: [ aMrlBehavior mrlInstanceVariablesAccesses isEmpty ]
]

{ #category : #applying }
TaskListReturnStrategy >> applyOn: aMrlBehavior [
	aMrlBehavior createTaskWithReturnStrategy
]
