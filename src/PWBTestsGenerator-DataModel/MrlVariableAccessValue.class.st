Class {
	#name : #MrlVariableAccessValue,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'access_id',
		'mrlvalue'
	],
	#category : #'PWBTestsGenerator-DataModel-Model'
}

{ #category : #accessing }
MrlVariableAccessValue >> access_id [
	^ access_id
]

{ #category : #accessing }
MrlVariableAccessValue >> access_id: anObject [
	access_id := anObject
]

{ #category : #accessing }
MrlVariableAccessValue >> mrlValue [
	self shouldBeImplemented.
]

{ #category : #accessing }
MrlVariableAccessValue >> mrlvalue [
	^ mrlvalue
]

{ #category : #accessing }
MrlVariableAccessValue >> mrlvalue: anObject [
	mrlvalue := anObject
]
