Class {
	#name : #MrlVariableAccessBeforeValueDescriptorSystem,
	#superclass : #MrlDescriptorAbstractSystem,
	#category : #'PWBTestGenerator-DataModel-SystemDescriptors'
}

{ #category : #accessing }
MrlVariableAccessBeforeValueDescriptorSystem >> allTableNames [
	"Return a list of all the table names that this system uses."
	^#('Maryline_access_before_value')
]

{ #category : #accessing }
MrlVariableAccessBeforeValueDescriptorSystem >> classModelForMaryline_access_before_value: aClassModel [
	aClassModel newAttributeNamed: #access_id.
	aClassModel newAttributeNamed: #mrlvalue.
	aClassModel newAttributeNamed: #dataobject
]

{ #category : #accessing }
MrlVariableAccessBeforeValueDescriptorSystem >> descriptorForMrlVariableAccessBeforeValue: aDescriptor [
	| table |
	table := self tableNamed: 'public."Maryline_access_before_value"'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #access_id
		to: (table fieldNamed: 'access_id').
	(aDescriptor newMapping: DirectMapping)
		from: #mrlvalue
		to: (table fieldNamed: 'mrlvalue').
	(aDescriptor newMapping: DirectMapping)
		from: #dataobject
		to: (table fieldNamed: 'dataobject')
]

{ #category : #accessing }
MrlVariableAccessBeforeValueDescriptorSystem >> tableForMARYLINE_ACCESS_BEFORE_VALUE: aTable [
	aTable createFieldNamed: 'access_id' type: platform int4.
	aTable createFieldNamed: 'mrlvalue' type: (platform varChar: 100).
	aTable createFieldNamed: 'dataobject' type: (platform varChar: 100)
]
