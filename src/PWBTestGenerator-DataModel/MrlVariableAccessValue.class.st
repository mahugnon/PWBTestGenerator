Class {
	#name : #MrlVariableAccessValue,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'access_id',
		'mrlvalue',
		'dataobject'
	],
	#category : #'PWBTestGenerator-DataModel-Model'
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
MrlVariableAccessValue >> dataobject [
	^ dataobject
]

{ #category : #accessing }
MrlVariableAccessValue >> dataobject: anObject [
	dataobject := anObject
]

{ #category : #accessing }
MrlVariableAccessValue >> mrlValue [
	^ mrlvalue
]

{ #category : #accessing }
MrlVariableAccessValue >> mrlvalue [
	^ mrlvalue
]

{ #category : #accessing }
MrlVariableAccessValue >> mrlvalue: anObject [
	mrlvalue := anObject
]
