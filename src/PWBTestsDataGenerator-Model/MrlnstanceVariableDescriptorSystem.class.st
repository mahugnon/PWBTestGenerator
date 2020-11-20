Class {
	#name : #MrlnstanceVariableDescriptorSystem,
	#superclass : #MrlDescriptorAbstractSystem,
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #accessing }
MrlnstanceVariableDescriptorSystem >> allTableNames [
	"Return a list of all the table names that this system uses."
	^#('Maryline_instance_variable')
]

{ #category : #'as yet unclassified' }
MrlnstanceVariableDescriptorSystem >> classModelForMaryline_instance_variable: aClassModel [
	aClassModel newAttributeNamed: #mrlValue.
	aClassModel newAttributeNamed: #instance_variable_dataobject.
	aClassModel newAttributeNamed: #instance_variable_id.
	aClassModel newAttributeNamed: #instance_variable_name.
	aClassModel newAttributeNamed: #instance_variable_pwb_object
]

{ #category : #'as yet unclassified' }
MrlnstanceVariableDescriptorSystem >> descriptorForMrlnstanceVariable: aDescriptor [
	| table |
	table := self tableNamed: 'public."Maryline_instance_variable"'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #instance_variable_dataobject
		to: (table fieldNamed: 'instance_variable_dataobject').
	(aDescriptor newMapping: DirectMapping)
		from: #instance_variable_id
		to: (table fieldNamed: 'instance_variable_id').
	(aDescriptor newMapping: DirectMapping)
		from: #instance_variable_name
		to: (table fieldNamed: 'instance_variable_name').
	(aDescriptor newMapping: DirectMapping)
		from: #instance_variable_pwb_object
		to: (table fieldNamed: 'instance_variable_pwb_object')
]

{ #category : #'as yet unclassified' }
MrlnstanceVariableDescriptorSystem >> tableForMARYLINE_INSTANCE_VARIABLE: aTable [
	(aTable createFieldNamed: 'instance_variable_id' type: platform int4)
		bePrimaryKey.
	aTable
		createFieldNamed: 'instance_variable_dataobject'
		type: (platform varChar: 100).
	aTable
		createFieldNamed: 'instance_variable_name'
		type: (platform varChar: 100).
	aTable
		createFieldNamed: 'instance_variable_pwb_object'
		type: (platform varChar: 100)
]
