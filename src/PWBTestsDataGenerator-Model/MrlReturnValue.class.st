Class {
	#name : #MrlReturnValue,
	#superclass : #MrlAbstractModel,
	#instVars : [
		'mrlValue',
		'behavior_id',
		'line_number',
		'timestamp'
	],
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #'as yet unclassified' }
MrlReturnValue class >> session [
	| session login |
	login := self login.
	session := MrlReturnValueDescriptorSystem
		sessionForLogin: login.
	session login.
	^ session
]

{ #category : #accessing }
MrlReturnValue >> behavior_id [
	^ behavior_id
]

{ #category : #accessing }
MrlReturnValue >> behavior_id: anObject [
	behavior_id := anObject
]

{ #category : #accessing }
MrlReturnValue >> line_number [
	^ line_number
]

{ #category : #accessing }
MrlReturnValue >> line_number: anObject [
	line_number := anObject
]

{ #category : #accessing }
MrlReturnValue >> mrlValue [
	^ mrlValue
]

{ #category : #accessing }
MrlReturnValue >> mrlValue: anObject [
	mrlValue := anObject
]

{ #category : #accessing }
MrlReturnValue >> timestamp [
	^ timestamp
]

{ #category : #accessing }
MrlReturnValue >> timestamp: anObject [
	timestamp := anObject
]
