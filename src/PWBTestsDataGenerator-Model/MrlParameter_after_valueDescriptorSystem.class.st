Class {
	#name : #'MrlParameter_after_valueDescriptorSystem',
	#superclass : #MrlDescriptorAbstractSystem,
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #accessing }
MrlParameter_after_valueDescriptorSystem >> allTableNames [
	"Return a list of all the table names that this system uses."
	^#('Maryline_parameter_after_value')
]

{ #category : #'as yet unclassified' }
MrlParameter_after_valueDescriptorSystem >> classModelForParameter_after_value: aClassModel [
	aClassModel newAttributeNamed: #parameter_id.
	aClassModel newAttributeNamed: #parameter_value
]

{ #category : #'as yet unclassified' }
MrlParameter_after_valueDescriptorSystem >> descriptorForMrlParameter_after_value: aDescriptor [
	| table |
	table := self tableNamed: 'public."Maryline_parameter_after_value"'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #parameter_id
		to: (table fieldNamed: 'parameter_id').
	(aDescriptor newMapping: DirectMapping)
		from: #parameter_value
		to: (table fieldNamed: 'parameter_value')
]

{ #category : #'as yet unclassified' }
MrlParameter_after_valueDescriptorSystem >> tableForMARYLINE_PARAMETER_AFTER_VALUE: aTable [
	| fk_parameter |
	fk_parameter := aTable
		createFieldNamed: 'parameter_id'
		type: platform int4.
	aTable
		createFieldNamed: 'parameter_value'
		type: (platform varChar: 100).
	"aTable
		addForeignKeyFrom: fk_parameter
		to:
			((self tableNamed: 'MARYLINE_PARAMETER')
				fieldNamed: 'parameter_id')"
]
