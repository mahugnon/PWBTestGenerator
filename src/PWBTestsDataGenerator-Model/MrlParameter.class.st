Class {
	#name : #MrlParameter,
	#superclass : #MrlAbstractModel,
	#instVars : [
		'parameter_id',
		'parameter_name',
		'parameter_before_value',
		'parameter_after_value',
		'parameter_syntax',
		'line_number',
		'timestamp',
		'behavior_id',
		'parameter_selectSql',
		'originalParameter',
		'parameter_dataobject'
	],
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #accessing }
MrlParameter class >> session [
	| session login |
	login := self login.
	session := MrlParameterDescriptorSystem sessionForLogin: login.
	session login.
	^ session
]

{ #category : #accessing }
MrlParameter >> behavior_id [
	^ behavior_id
]

{ #category : #accessing }
MrlParameter >> behavior_id: anObject [
	behavior_id := anObject
]

{ #category : #testing }
MrlParameter >> ifIsDataWindow: aBlock [
	^ self isPWBDataWindow
		ifTrue: aBlock
]

{ #category : #testing }
MrlParameter >> isBasic [
	^ originalParameter isBasic
]

{ #category : #testing }
MrlParameter >> isPWBDataWindow [
	^ self originalParameter isPWBDataWindow
]

{ #category : #accessing }
MrlParameter >> line_number [
	^ line_number
]

{ #category : #accessing }
MrlParameter >> line_number: anObject [
	line_number := anObject
]

{ #category : #accessing }
MrlParameter >> loadMrlParameter_after_value [
	parameter_after_value := (MrlParameter_after_value
		loadWhere:
			[ :mrlParameter_value | mrlParameter_value parameter_id = self parameter_id ])
		anyOne
]

{ #category : #accessing }
MrlParameter >> loadMrlParameter_before_value [
	parameter_before_value := (MrlParameter_before_value
		loadWhere:
			[ :mrlParameter_value | mrlParameter_value parameter_id = self parameter_id ])
		anyOne
]

{ #category : #accessing }
MrlParameter >> originalParameter [
	^ originalParameter
]

{ #category : #accessing }
MrlParameter >> originalParameter: anObject [
	originalParameter := anObject
]

{ #category : #accessing }
MrlParameter >> parameterType [
	^ originalParameter parameterType
]

{ #category : #accessing }
MrlParameter >> parameterTypeName [
	^ self parameterType name
]

{ #category : #accessing }
MrlParameter >> parameter_after_value [
	parameter_after_value ifNil: [ self loadMrlParameter_after_value ].
	^ parameter_after_value parameter_value
]

{ #category : #accessing }
MrlParameter >> parameter_before_value [
	parameter_before_value ifNil: [ self loadMrlParameter_before_value ].
	^ parameter_before_value parameter_value
]

{ #category : #accessing }
MrlParameter >> parameter_dataobject [
	^ parameter_dataobject
]

{ #category : #accessing }
MrlParameter >> parameter_dataobject: anObject [
	parameter_dataobject := anObject
]

{ #category : #accessing }
MrlParameter >> parameter_id [
	^ parameter_id
]

{ #category : #accessing }
MrlParameter >> parameter_id: anObject [
	parameter_id := anObject
]

{ #category : #accessing }
MrlParameter >> parameter_name [
	^ parameter_name
]

{ #category : #accessing }
MrlParameter >> parameter_name: anObject [
	parameter_name := anObject
]

{ #category : #accessing }
MrlParameter >> parameter_selectSql [
	^ parameter_selectSql
]

{ #category : #accessing }
MrlParameter >> parameter_selectSql: anObject [
	parameter_selectSql := anObject
]

{ #category : #accessing }
MrlParameter >> parameter_syntax [
	^ parameter_syntax
]

{ #category : #accessing }
MrlParameter >> parameter_syntax: anObject [
	parameter_syntax := anObject
]

{ #category : #accessing }
MrlParameter >> startPosition [
	^ originalParameter startPos
]

{ #category : #accessing }
MrlParameter >> timestamp [
	^ timestamp
]

{ #category : #accessing }
MrlParameter >> timestamp: anObject [
	timestamp := anObject
]
