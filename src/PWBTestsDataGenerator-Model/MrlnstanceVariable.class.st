Class {
	#name : #MrlnstanceVariable,
	#superclass : #MrlAbstractModel,
	#instVars : [
		'instance_variable_dataobject',
		'instance_variable_id',
		'instance_variable_name',
		'instance_variable_pwb_object',
		'accesses',
		'famixPWBAttribute'
	],
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #'as yet unclassified' }
MrlnstanceVariable class >> session [
	| session login |
	login := self login.
	session := MrlnstanceVariableDescriptorSystem
		sessionForLogin: login.
	session login.
	^ session
]

{ #category : #accessing }
MrlnstanceVariable >> accesses [
	accesses ifEmpty: [ self loadAccesses ].
	^ (accesses groupedBy: #timestamp) asOrderedDictionary
]

{ #category : #initialization }
MrlnstanceVariable >> initialize [
	super initialize.
	accesses := OrderedCollection new
]

{ #category : #accessing }
MrlnstanceVariable >> instance_variable_dataobject [
	^ instance_variable_dataobject
]

{ #category : #accessing }
MrlnstanceVariable >> instance_variable_dataobject: anObject [
	instance_variable_dataobject := anObject
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
	^ self linkToFamixAttributeInModel: MooseModel root first
]

{ #category : #accessing }
MrlnstanceVariable >> loadAccesses [
	^ accesses := MrlInstanceVariableAccess
		loadWhere:
			[ :access | access instance_variable_access_accessed = self instance_variable_id ]
]

{ #category : #initialization }
MrlnstanceVariable >> type [
	famixPWBAttribute ifNil: [ self linkToFamixPWBAttribute ].
	^ famixPWBAttribute attributeType
]

{ #category : #initialization }
MrlnstanceVariable >> typeName [
	famixPWBAttribute ifNil: [ self linkToFamixPWBAttribute ].
	^ famixPWBAttribute typeName
]
