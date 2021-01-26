Class {
	#name : #MrlnstanceVariable,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'instance_variable_id',
		'instance_variable_name',
		'instance_variable_pwb_object',
		'accesses',
		'famixPWBAttribute',
		'type',
		'mooseModel'
	],
	#category : #'PWBTestGenerator-DataModel-Model'
}

{ #category : #accessing }
MrlnstanceVariable >> accesses [
	accesses ifEmpty: [ self loadAccesses ].
	^ (accesses groupedBy: #timestamp) asOrderedDictionary
]

{ #category : #comparing }
MrlnstanceVariable >> equals: anObject [
	^ self instance_variable_name = anObject instance_variable_name
]

{ #category : #initialization }
MrlnstanceVariable >> initialize [
	super initialize.
	accesses := OrderedCollection new
]

{ #category : #accessing }
MrlnstanceVariable >> instance_variable_id [
	^ instance_variable_id
]

{ #category : #accessing }
MrlnstanceVariable >> instance_variable_id: anObject [
	instance_variable_id := anObject
]

{ #category : #accessing }
MrlnstanceVariable >> instance_variable_name [
	^ instance_variable_name
]

{ #category : #accessing }
MrlnstanceVariable >> instance_variable_name: anObject [
	instance_variable_name := anObject
]

{ #category : #accessing }
MrlnstanceVariable >> instance_variable_pwb_object [
	^ instance_variable_pwb_object
]

{ #category : #accessing }
MrlnstanceVariable >> instance_variable_pwb_object: anObject [
	instance_variable_pwb_object := anObject
]

{ #category : #initialization }
MrlnstanceVariable >> isBasic [
	^ self type isBasic
]

{ #category : #initialization }
MrlnstanceVariable >> linkToFamixAttributeInModel: aMooseModel [
	famixPWBAttribute := (aMooseModel
		allWithType: FamixPWBInstanceVariable)
		detect: [ :var | 
			var name = instance_variable_name
				and: [ var parentType name = instance_variable_pwb_object ] ]
]

{ #category : #initialization }
MrlnstanceVariable >> linkToFamixPWBAttribute [
	^ self linkToFamixAttributeInModel: mooseModel
]

{ #category : #accessing }
MrlnstanceVariable >> loadAccesses [
	^ accesses := MrlInstanceVariableAccess
		loadWhere:
			[ :access | access instance_variable_access_accessed = self instance_variable_id ]
]

{ #category : #accessing }
MrlnstanceVariable >> mooseModel: anUndefinedObject [ 
	mooseModel := anUndefinedObject
]

{ #category : #initialization }
MrlnstanceVariable >> type [
	famixPWBAttribute ifNil: [ self linkToFamixPWBAttribute ].
	^ famixPWBAttribute attributeType
]

{ #category : #initialization }
MrlnstanceVariable >> typeName [
	^ self type name
]
