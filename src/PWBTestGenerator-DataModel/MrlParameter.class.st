Class {
	#name : #MrlParameter,
	#superclass : #PWBAbstractModel,
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
	#category : #'PWBTestGenerator-DataModel-Model'
}

{ #category : #accessing }
MrlParameter >> afterValue [
	^ self parameter_after_value
]

{ #category : #accessing }
MrlParameter >> beforeValue [
	^ self parameter_before_value
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
	parameter_after_value := MrlParameter_after_value
		loadWhere:
			[ :mrlParameter_value | mrlParameter_value parameter_id = self parameter_id ]
		limit: 1.
	parameter_after_value := parameter_after_value
		ifEmpty: [  ]
		ifNotEmpty: [ parameter_after_value anyOne ]
]

{ #category : #accessing }
MrlParameter >> loadMrlParameter_before_value [
	parameter_before_value := (MrlParameter_before_value
		loadWhere:
			[ :mrlParameter_value | mrlParameter_value parameter_id = self parameter_id ])
		ifNotEmpty: [ :val | val anyOne ]
		ifEmpty: [ nil ]
]

{ #category : #'as yet unclassified' }
MrlParameter >> loadValue [
	self loadMrlParameter_before_value.
	self loadMrlParameter_after_value
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
	^ parameter_after_value
		ifNotNil: [ parameter_after_value parameter_value ]
		ifNil: [ nil ]
]

{ #category : #accessing }
MrlParameter >> parameter_after_value: anObject [
	parameter_after_value := anObject
]

{ #category : #accessing }
MrlParameter >> parameter_before_value [
	^ parameter_before_value
]

{ #category : #accessing }
MrlParameter >> parameter_before_value: anObject [
	parameter_before_value := anObject
]

{ #category : #'as yet unclassified' }
MrlParameter >> parameter_dataobjectForTag: aTag [
	^ aTag = 'before'
		ifTrue: [ parameter_before_value parameter_dataobject ]
		ifFalse: [ parameter_after_value parameter_dataobject ]
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
	^ originalParameter sourceAnchor startPos
]

{ #category : #accessing }
MrlParameter >> timestamp [
	^ timestamp
]

{ #category : #accessing }
MrlParameter >> timestamp: anObject [
	timestamp := anObject
]
