Class {
	#name : #MrlBehavior,
	#superclass : #MrlAbstractModel,
	#instVars : [
		'behaviorUnderTest',
		'behavior_name',
		'pwb_object',
		'sender',
		'behavior_id',
		'mrlParameters',
		'mrlReturnValues',
		'timestamps',
		'mrlInstanceVariablesAccesses'
	],
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #'as yet unclassified' }
MrlBehavior class >> behaviorFromModel: aFamixPWBModel [
	| famixBehaviors |
	famixBehaviors := (aFamixPWBModel allWithType: FamixPWBFunction)
		, (aFamixPWBModel allWithType: FamixPWBSubRoutine)
		select: [ :each | each parentType isNotNil ].
	^ aFamixPWBModel
		setBusinessRuleFunctions:
			((self loadAll
				flatCollectAsSet: [ :aBehavior | 
					famixBehaviors
						select: [ :each | 
							each parentType name = aBehavior pwb_object
								and: [ each name = aBehavior behavior_name ] ] ])
				groupedBy: #parentType)
]

{ #category : #'as yet unclassified' }
MrlBehavior class >> loadAll [
	^ super loadAll
		reject: [ :each | 
			{'nvo_mdb_rdg' . 'nvo_config' . 'nvo_database_manager'.
			'nvo_tools_file' . 'nvo_tools_ini'.'nvo_database_transac_properties'.'nvo_database_base'}
				anySatisfy: [ :aString | aString = each pwb_object ] ]
]

{ #category : #accessing }
MrlBehavior class >> loadAllWithMrlParameterAndMrlReturnValues [
	^ self loadAll do: #loadMrlParametersAndReturnValues
]

{ #category : #accessing }
MrlBehavior class >> loadAllWithMrlParameters [
	^ self loadAll do: #loadMrlParameters
]

{ #category : #accessing }
MrlBehavior class >> loadWithMrlParameterAndMrlReturnValuesWhere: aBlock [
	^ (self loadWhere: aBlock) do: #loadMrlParametersAndReturnValues
]

{ #category : #'as yet unclassified' }
MrlBehavior class >> session [
	| session login |
	login := self login.
	session := MrlBehaviorDescriptorSystem sessionForLogin: login.
	session login.
	^ session
]

{ #category : #adding }
MrlBehavior >> addAllMrlParameters: aCollection [
	mrlParameters addAll: aCollection
]

{ #category : #adding }
MrlBehavior >> addAllMrlReturnValues: aCollection [
	mrlReturnValues addAll: aCollection
]

{ #category : #adding }
MrlBehavior >> addMrlParameter: aMrlParameter [
	mrlParameters add: aMrlParameter
]

{ #category : #adding }
MrlBehavior >> addMrlReturnValue: aMrlReturnValue [
	mrlReturnValues add: aMrlReturnValue
]

{ #category : #accessing }
MrlBehavior >> behaviorUnderTest [
	^ behaviorUnderTest
]

{ #category : #accessing }
MrlBehavior >> behaviorUnderTest: anObject [
	behaviorUnderTest := anObject.
	self setOriginalParameters
]

{ #category : #accessing }
MrlBehavior >> behavior_id [
	^ behavior_id
]

{ #category : #accessing }
MrlBehavior >> behavior_id: anObject [
	behavior_id := anObject
]

{ #category : #accessing }
MrlBehavior >> behavior_name [
	^ behavior_name
]

{ #category : #accessing }
MrlBehavior >> behavior_name: anObject [
	behavior_name := anObject
]

{ #category : #'as yet unclassified' }
MrlBehavior >> createAssertionsFromData [
	| assertons |
	assertons := OrderedCollection new.
	self mrlParameters
		keysAndValuesDo: [ :key :value | 
			(value allSatisfy: #isBasic)
				ifTrue: [ assertons
						add:
							(self
								ensureCreateAssertion: PWBFunctionWithBasicTypesParametersUnitAssertion
								with: key
								and: value) ]
				ifFalse: [ assertons
						add:
							(self
								ensureCreateAssertion: PWBFunctionWithDataWindowParametersUnitAssertion
								with: key
								and: value) ] ].
	^ assertons
]

{ #category : #'as yet unclassified' }
MrlBehavior >> ensureCreateAssertion: assertionClass with: timeStamp and: aCollection [
	^ assertionClass new
		mrlParameters: aCollection;
		originalBehavior: self behaviorUnderTest;
		behaviorName: self behavior_name;
		behaviorParent: self pwb_object;
		timestamp: timeStamp;
		behaviorReturnValue:
			(self mrlReturnValues
				detect: [ :returnValue | returnValue timestamp = timeStamp ]);
		yourself
]

{ #category : #'as yet unclassified' }
MrlBehavior >> generateTestCaseFromData [
	PWBTestCase
		testCaseForFunction:
			((MooseModel root first allWithType: FamixPWBFunction)
				detect: [ :uf | uf name = self behavior_name ])
]

{ #category : #'as yet unclassified' }
MrlBehavior >> getInstanceVariableAccess: aTimestampString [
	^ self mrlInstanceVariablesAccesses at: aTimestampString
]

{ #category : #initialization }
MrlBehavior >> initialize [
	super initialize.
	mrlParameters := OrderedCollection new.
	mrlReturnValues := OrderedCollection new.
	mrlInstanceVariablesAccesses := OrderedCollection new
]

{ #category : #'as yet unclassified' }
MrlBehavior >> loadMrlInstanceVariablesAccesses [
	mrlInstanceVariablesAccesses := MrlInstanceVariableAccess
		loadWhere: [ :mrlInstanceVariablesAccess | 
			mrlInstanceVariablesAccess instance_variable_access_accessor
				= self behavior_id ]
]

{ #category : #'as yet unclassified' }
MrlBehavior >> loadMrlParameters [
	mrlParameters := MrlParameter
		loadWhere: [ :mrlParameter | mrlParameter behavior_id = self behavior_id ]
]

{ #category : #'as yet unclassified' }
MrlBehavior >> loadMrlParametersAndReturnValues [
	self
		loadMrlParameters;
		loadMrlReturnValues
]

{ #category : #'as yet unclassified' }
MrlBehavior >> loadMrlReturnValues [
	self
		addAllMrlReturnValues:
			(MrlReturnValue
				loadWhere: [ :mrlReturnValue | mrlReturnValue behavior_id = self behavior_id ])
]

{ #category : #'as yet unclassified' }
MrlBehavior >> mrlInstanceVariablesAccesses [
	mrlInstanceVariablesAccesses
		ifEmpty: [ self loadMrlInstanceVariablesAccesses ].
	^ (mrlInstanceVariablesAccesses groupedBy: #instance_variable_access_timestamp)
		asOrderedDictionary
]

{ #category : #accessing }
MrlBehavior >> mrlParameters [
	mrlParameters ifEmpty: [ self loadMrlParameters ].
	^ (mrlParameters groupedBy: #timestamp) asOrderedDictionary
]

{ #category : #accessing }
MrlBehavior >> mrlReturnValues [
	mrlReturnValues ifEmpty: [ self loadMrlReturnValues ].
	^ mrlReturnValues
]

{ #category : #accessing }
MrlBehavior >> pwb_object [
	^ pwb_object
]

{ #category : #accessing }
MrlBehavior >> pwb_object: anObject [
	pwb_object := anObject
]

{ #category : #accessing }
MrlBehavior >> returnType [
	^ behaviorUnderTest returnType name
]

{ #category : #accessing }
MrlBehavior >> sender [
	^ sender
]

{ #category : #accessing }
MrlBehavior >> sender: anObject [
	sender := anObject
]

{ #category : #'as yet unclassified' }
MrlBehavior >> setOriginalParameters [
	mrlParameters
		do: [ :param | 
			param
				originalParameter:
					(behaviorUnderTest parameters
						detect: [ :parameter | parameter name = param parameter_name ]) ]
]

{ #category : #accessing }
MrlBehavior >> timestamps [
	timestamps ifNil: [ timestamps := self mrlParameters keys ].
	^ timestamps
]
