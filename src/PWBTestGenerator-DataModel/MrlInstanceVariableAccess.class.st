Class {
	#name : #MrlInstanceVariableAccess,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'instance_variable_access_accessed',
		'instance_variable_access_accessor',
		'instance_variable_access_id',
		'instance_variable_access_timestamp',
		'beforeValue',
		'afterValue',
		'variable'
	],
	#category : #'PWBTestGenerator-DataModel-Model'
}

{ #category : #accessing }
MrlInstanceVariableAccess >> afterValue [
	beforeValue
		ifNil: [ afterValue := (MrlVariableAccessAfterValue
				loadWhere:
					[ :access_value | access_value access_id = self instance_variable_access_id ])
				anyOne ].
	^ beforeValue mrlValue
]

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccess >> afterValueDataobject [
	^ self afterValue dataobject
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

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccess >> beforeValueDataobject [
	^ self beforeValue dataobject
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

{ #category : #tests }
MrlInstanceVariableAccess >> pwbTestVariableName [
	^ String
		streamContents: [ :stream | 
			stream
				<< 'l';
				<< self variable instance_variable_pwb_object;
				nextPut: $.;
				<< (self variableName copyReplaceAll: 'this.' with: '') ]
]

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccess >> variable [
	self loadVariable.
	^ variable
]

{ #category : #accessing }
MrlInstanceVariableAccess >> variableName [
	^ self variable instance_variable_name
]

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccess >> variableTypeName [
	^ variable typeName
]
