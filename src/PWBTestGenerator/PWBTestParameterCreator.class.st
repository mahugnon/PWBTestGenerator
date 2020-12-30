Class {
	#name : #PWBTestParameterCreator,
	#superclass : #Object,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #visiting }
PWBTestParameterCreator class >> accept: aMrlParam [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBTestParameterCreator class >> param: param on: stream [
	(self subclasses detect: [ :sub | sub accept: param ]) new
		param: param
		on: stream
]

{ #category : #'as yet unclassified' }
PWBTestParameterCreator >> param: param on: stream [
	self subclassResponsibility
]
