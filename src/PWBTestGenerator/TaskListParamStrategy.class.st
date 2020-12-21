Class {
	#name : #TaskListParamStrategy,
	#superclass : #TaskListStrategy,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #'as yet unclassified' }
TaskListParamStrategy class >> accept: aMrlBehavior [
	^ aMrlBehavior pwbParameters isNotEmpty
]

{ #category : #applying }
TaskListParamStrategy >> applyOn: aMrlBehavior [
	^ aMrlBehavior createTaskWithParamStrategy
]
