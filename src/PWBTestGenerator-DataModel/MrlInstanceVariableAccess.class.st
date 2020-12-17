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
		'mooseModel'
	],
	#category : #'PWBTestGenerator-DataModel-Model'
}

{ #category : #accessing }
MrlInstanceVariableAccess >> afterValue [
	afterValue
		ifNil: [ afterValue := (MrlVariableAccessAfterValue
				loadWhere:
					[ :access_value | access_value access_id = self instance_variable_access_id ])
				anyOne ].
	^ afterValue
]

{ #category : #accessing }
MrlInstanceVariableAccess >> afterValue: aMrlVariableAccessAfterValue [ 
	afterValue := aMrlVariableAccessAfterValue
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
	^ beforeValue
]

{ #category : #accessing }
MrlInstanceVariableAccess >> beforeValue: aMrlVariableAccessBeforeValue [ 
	beforeValue := aMrlVariableAccessBeforeValue
]

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccess >> beforeValueDataobject [
	^ self beforeValue dataobject
]

{ #category : #accessing }
MrlInstanceVariableAccess >> instance_variable_access_accessed [
	self loadInstance_variable_access_accessed.
	^ instance_variable_access_accessed
]

{ #category : #accessing }
MrlInstanceVariableAccess >> instance_variable_access_accessed: anObject [
	instance_variable_access_accessed := anObject
]

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccess >> instance_variable_access_accessedTypeName [
	^ self instance_variable_access_accessed typeName
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
	^ instance_variable_access_accessed isBasic
]

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccess >> loadInstance_variable_access_accessed [
	instance_variable_access_accessed
		ifNil: [ instance_variable_access_accessed := (MrlnstanceVariable
				loadWhere:
					[ :var | var instance_variable_id = self instance_variable_access_accessed ])
				anyOne ].
	instance_variable_access_accessed mooseModel: mooseModel
]

{ #category : #accessing }
MrlInstanceVariableAccess >> mooseModel: anObject [
	mooseModel := anObject
]

{ #category : #tests }
MrlInstanceVariableAccess >> pwbTestVariableName [
	^ String
		streamContents: [ :stream | 
			stream
				<< 'l';
				<< self instance_variable_access_accessed instance_variable_pwb_object;
				nextPut: $.;
				<< (self variableName copyReplaceAll: 'this.' with: '') ]
]

{ #category : #accessing }
MrlInstanceVariableAccess >> variableName [
	^ self instance_variable_access_accessed instance_variable_name
]
