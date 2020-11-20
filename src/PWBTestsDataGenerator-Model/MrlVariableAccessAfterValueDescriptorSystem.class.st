Class {
	#name : #MrlVariableAccessAfterValueDescriptorSystem,
	#superclass : #MrlDescriptorAbstractSystem,
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #accessing }
MrlVariableAccessAfterValueDescriptorSystem >> allTableNames [
	"Return a list of all the table names that this system uses."
	^#('Maryline_access_after_value')
]

{ #category : #'as yet unclassified' }
MrlVariableAccessAfterValueDescriptorSystem >> classModelForMaryline_access_after_value: aClassModel [
	aClassModel newAttributeNamed: #access_id.
	aClassModel newAttributeNamed: #mrlvalue
]

{ #category : #'as yet unclassified' }
MrlVariableAccessAfterValueDescriptorSystem >> descriptorForMrlVariableAccessAfterValue: aDescriptor [
	| table |
	table := self tableNamed: 'public."Maryline_access_after_value"'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #access_id
		to: (table fieldNamed: 'access_id').
	(aDescriptor newMapping: DirectMapping)
		from: #mrlvalue
		to: (table fieldNamed: 'mrlvalue')
]

{ #category : #'as yet unclassified' }
MrlVariableAccessAfterValueDescriptorSystem >> tableForMARYLINE_ACCESS_AFTER_VALUE: aTable [
	| fk |
	fk := aTable
		createFieldNamed: 'access_id'
		type: platform int4.
	aTable
		createFieldNamed: 'mrlvalue'
		type: (platform varChar: 100).
	"aTable
		addForeignKeyFrom: fk
		to:
			((self tableNamed: 'MARYLINE_INSTANCE_VARIABLE_ACCESS')
				fieldNamed: 'instance_variable_access_id')"
]
