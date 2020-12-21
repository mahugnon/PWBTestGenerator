Class {
	#name : #TaskListStrategy,
	#superclass : #Object,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #'as yet unclassified' }
TaskListStrategy class >> accept: aMrlBehavior [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
TaskListStrategy class >> apply: aMrlBehavior [
	^ (self subclasses detect: [ :sub | sub accept: aMrlBehavior ]) new
		applyOn: aMrlBehavior
]

{ #category : #applying }
TaskListStrategy >> applyOn: aMrlBehavior [
	self subclassResponsibility
]
