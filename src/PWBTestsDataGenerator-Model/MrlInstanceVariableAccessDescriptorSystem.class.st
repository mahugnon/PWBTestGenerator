Class {
	#name : #MrlInstanceVariableAccessDescriptorSystem,
	#superclass : #MrlDescriptorAbstractSystem,
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #accessing }
MrlInstanceVariableAccessDescriptorSystem >> allTableNames [
	"Return a list of all the table names that this system uses."
	^#('Maryline_instance_variable_access')
]

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccessDescriptorSystem >> classModelForMaryline_instance_variable_access: aClassModel [
	aClassModel newAttributeNamed: #instance_variable_access_id.
	aClassModel newAttributeNamed: #instance_variable_access_accessed.
	aClassModel newAttributeNamed: #instance_variable_access_accessor.
	aClassModel newAttributeNamed: #instance_variable_access_timestamp
]

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccessDescriptorSystem >> descriptorForMrlInstanceVariableAccess: aDescriptor [
	| table |
	table := self
		tableNamed: 'public."Maryline_instance_variable_access"'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #instance_variable_access_id
		to: (table fieldNamed: 'instance_variable_access_id').
	(aDescriptor newMapping: DirectMapping)
		from: #instance_variable_access_accessor
		to: (table fieldNamed: 'instance_variable_access_accessor').
	(aDescriptor newMapping: DirectMapping)
		from: #instance_variable_access_accessed
		to: (table fieldNamed: 'instance_variable_access_accessed').
	(aDescriptor newMapping: DirectMapping)
		from: #instance_variable_access_timestamp
		to: (table fieldNamed: 'instance_variable_access_timestamp')
]

{ #category : #'as yet unclassified' }
MrlInstanceVariableAccessDescriptorSystem >> tableForMARYLINE_INSTANCE_VARIABLE_ACCESS: aTable [
	| fk1 fk2 |
	(aTable
		createFieldNamed: 'instance_variable_access_id'
		type: platform int4) bePrimaryKey.
	fk1 := aTable
		createFieldNamed: 'instance_variable_access_accessor'
		type: platform int4.
	fk2 := aTable
		createFieldNamed: 'instance_variable_access_accessed'
		type: platform int4.
	aTable
		createFieldNamed: 'instance_variable_access_timestamp'
		type: (platform varChar: 100).
	"aTable
		addForeignKeyFrom: fk1
		to: ((self tableNamed: 'MARYLINE_BEHAVIOR') fieldNamed: 'behavior_id').
	aTable
		addForeignKeyFrom: fk2
		to:
			((self tableNamed: 'MARYLINE_INSTANCE_VARIABLE_ACCESS')
				fieldNamed: 'instance_variable_id')"
]
