Class {
	#name : #MrlReturnValueDescriptorSystem,
	#superclass : #MrlDescriptorAbstractSystem,
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #accessing }
MrlReturnValueDescriptorSystem >> allTableNames [
	"Return a list of all the table names that this system uses."
	^#('Maryline_return_value')
]

{ #category : #'as yet unclassified' }
MrlReturnValueDescriptorSystem >> classModelForMaryline_return_value: aClassModel [
	aClassModel newAttributeNamed: #mrlValue.
	aClassModel newAttributeNamed: #behavior_id.
	aClassModel newAttributeNamed: #line_number.
	aClassModel newAttributeNamed: #timestamp
]

{ #category : #'as yet unclassified' }
MrlReturnValueDescriptorSystem >> descriptorForMrlReturnValue: aDescriptor [
	| table |
	table := self tableNamed: 'public."Maryline_return_value"'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #mrlValue
		to: (table fieldNamed: 'value').
	(aDescriptor newMapping: DirectMapping)
		from: #behavior_id
		to: (table fieldNamed: 'behavior_id').
	(aDescriptor newMapping: DirectMapping)
		from: #line_number 
		to: (table fieldNamed: 'line_number').
		
(aDescriptor newMapping: DirectMapping)
		from: #timestamp  
		to: (table fieldNamed: 'timestamp').	
]

{ #category : #'as yet unclassified' }
MrlReturnValueDescriptorSystem >> tableForMARYLINE_RETURN_VALUE: aTable [
	aTable createFieldNamed: 'value' type: (platform varChar: 100).
	aTable createFieldNamed: 'behavior_id' type: platform int4.
	aTable createFieldNamed: 'line_number' type: (platform varChar: 100).
	aTable createFieldNamed: 'timestamp' type: (platform varChar: 100)
]
