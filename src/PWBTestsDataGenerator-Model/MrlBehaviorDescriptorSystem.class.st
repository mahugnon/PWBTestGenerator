Class {
	#name : #MrlBehaviorDescriptorSystem,
	#superclass : #MrlDescriptorAbstractSystem,
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #accessing }
MrlBehaviorDescriptorSystem >> allTableNames [
	"Return a list of all the table names that this system uses."
	^#('Maryline_behavior')
]

{ #category : #'as yet unclassified' }
MrlBehaviorDescriptorSystem >> classModelForMaryline_behavior: aClassModel [
	aClassModel newAttributeNamed: #behavior_id.
	aClassModel newAttributeNamed: #behavior_name.
	aClassModel newAttributeNamed: #pwb_object.
	aClassModel newAttributeNamed: #sender
]

{ #category : #'as yet unclassified' }
MrlBehaviorDescriptorSystem >> descriptorForMrlBehavior: aDescriptor [
	| table |
	table := self tableNamed: 'public."Maryline_behavior"'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #behavior_id
		to: (table fieldNamed: 'behavior_id').
	(aDescriptor newMapping: DirectMapping)
		from: #behavior_name
		to: (table fieldNamed: 'behavior_name').
	(aDescriptor newMapping: DirectMapping)
		from: #sender
		to: (table fieldNamed: 'sender').
	(aDescriptor newMapping: DirectMapping)
		from: #pwb_object
		to: (table fieldNamed: 'pwb_object')
]

{ #category : #'as yet unclassified' }
MrlBehaviorDescriptorSystem >> tableForMARYLINE_BEHAVIOR: aTable [
	(aTable createFieldNamed: 'behavior_id' type: platform int4)
		bePrimaryKey.
	aTable
		createFieldNamed: 'behavior_name'
		type: (platform varChar: 100).
	aTable createFieldNamed: 'sender' type: (platform varChar: 100).
	aTable createFieldNamed: 'pwb_object' type: (platform varChar: 100)
]
