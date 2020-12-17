Class {
	#name : #'MrlParameter_value',
	#superclass : #PWBAbstractModel,
	#instVars : [
		'parameter_id',
		'parameter_value',
		'parameter_dataobject'
	],
	#category : #'PWBTestGenerator-DataModel-Model'
}

{ #category : #accessing }
MrlParameter_value >> mrlValue [
	^ self parameter_value
]

{ #category : #accessing }
MrlParameter_value >> parameter_dataobject [
	^ parameter_dataobject
]

{ #category : #accessing }
MrlParameter_value >> parameter_dataobject: anObject [
	parameter_dataobject := anObject
]

{ #category : #accessing }
MrlParameter_value >> parameter_id [
	^ parameter_id
]

{ #category : #accessing }
MrlParameter_value >> parameter_id: anObject [
	parameter_id := anObject
]

{ #category : #accessing }
MrlParameter_value >> parameter_value [
	^ parameter_value
]

{ #category : #accessing }
MrlParameter_value >> parameter_value: anObject [
	parameter_value := anObject
]
