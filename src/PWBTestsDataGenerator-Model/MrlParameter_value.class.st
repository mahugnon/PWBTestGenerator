Class {
	#name : #'MrlParameter_value',
	#superclass : #MrlAbstractModel,
	#instVars : [
		'parameter_id',
		'parameter_value'
	],
	#category : #'PWBTestsDataGenerator-Model'
}

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
