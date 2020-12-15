Class {
	#name : #'MrlParameter_before_valueDescriptorSystem',
	#superclass : #MrlDescriptorAbstractSystem,
	#category : #'PWBTestGenerator-DataModel-SystemDescriptors'
}

{ #category : #accessing }
MrlParameter_before_valueDescriptorSystem >> allTableNames [
	"Return a list of all the table names that this system uses."
	^#('Maryline_parameter_before_value')
]

{ #category : #'as yet unclassified' }
MrlParameter_before_valueDescriptorSystem >> classModelForParameter_before_value: aClassModel [
	aClassModel newAttributeNamed: #parameter_id.
	aClassModel newAttributeNamed: #parameter_value.
	aClassModel newAttributeNamed: #parameter_dataobject
]

{ #category : #'as yet unclassified' }
MrlParameter_before_valueDescriptorSystem >> descriptorForMrlParameter_before_value: aDescriptor [
	| table |
	table := self tableNamed: 'public."Maryline_parameter_before_value"'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #parameter_id
		to: (table fieldNamed: 'parameter_id').
	(aDescriptor newMapping: DirectMapping)
		from: #parameter_value
		to: (table fieldNamed: 'parameter_value').
	(aDescriptor newMapping: DirectMapping)
		from: #parameter_dataobject
		to: (table fieldNamed: 'parameter_dataobject')
]

{ #category : #'as yet unclassified' }
MrlParameter_before_valueDescriptorSystem >> tableForMARYLINE_PARAMETER_BEFORE_VALUE: aTable [
	aTable createFieldNamed: 'parameter_id' type: platform int4.
	aTable
		createFieldNamed: 'parameter_value'
		type: (platform varChar: 100).
	aTable
		createFieldNamed: 'parameter_dataobject'
		type: (platform varChar: 100)
]
