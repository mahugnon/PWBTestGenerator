Class {
	#name : #MrlInstanceVariableAccess,
	#superclass : #MrlAbstractModel,
	#instVars : [
		'instance_variable_access_accessed',
		'instance_variable_access_accessor',
		'instance_variable_access_id',
		'instance_variable_access_timestamp',
		'beforeValue',
		'afterValue',
		'variable'
	],
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccess class >> session [
	| session login |
	login := self login.
	session := MrlInstanceVariableAccessDescriptorSystem
		sessionForLogin: login.
	session login.
	^ session
]

{ #category : #accessing }
MrlInstanceVariableAccess >> afterValue [
	beforeValue
		ifNil: [ afterValue := (MrlVariableAccessAfterValue
				loadWhere:
					[ :access_value | access_value access_id = self instance_variable_access_id ])
				anyOne ].
	^ beforeValue mrlValue
]

{ #category : #accessing }
MrlInstanceVariableAccess >> beforeValue [
	beforeValue
		ifNil: [ beforeValue := (MrlVariableAccessBeforeValue
				loadWhere:
					[ :access_value | access_value access_id = self instance_variable_access_id ])
				anyOne ].
	^ beforeValue mrlvalue
]

{ #category : #accessing }
MrlInstanceVariableAccess >> instance_variable_access_accessed [
	^ instance_variable_access_accessed
]

{ #category : #accessing }
MrlInstanceVariableAccess >> instance_variable_access_accessed: anObject [
	instance_variable_access_accessed := anObject
]

{ #category : #accessing }
MrlInstanceVariableAccess >> instance_variable_access_accessor [
	^ instance_variable_access_accessor
]

{ #category : #accessing }
MrlInstanceVariableAccess >> instance_variable_access_accessor: anObject [
	instance_variable_access_accessor := anObject
]

{ #category : #accessing }
MrlInstanceVariableAccess >> instance_variable_access_id [
	^ instance_variable_access_id
]

{ #category : #accessing }
MrlInstanceVariableAccess >> instance_variable_access_id: anObject [
	instance_variable_access_id := anObject
]

{ #category : #accessing }
MrlInstanceVariableAccess >> instance_variable_access_timestamp [
	^ instance_variable_access_timestamp
]

{ #category : #accessing }
MrlInstanceVariableAccess >> instance_variable_access_timestamp: anObject [
	instance_variable_access_timestamp := anObject
]

{ #category : #testing }
MrlInstanceVariableAccess >> isBasic [
	^ variable isBasic
]

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccess >> loadVariable [
	variable
		ifNil: [ variable := (MrlnstanceVariable
				loadWhere:
					[ :var | var instance_variable_id = self instance_variable_access_accessed ])
				anyOne ]
]

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccess >> variable [
	self loadVariable.
	^ variable instance_variable_name
]

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccess >> variableTypeName [
	^ variable typeName
]
