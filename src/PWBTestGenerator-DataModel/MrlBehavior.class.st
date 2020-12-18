Class {
	#name : #MrlBehavior,
	#superclass : #PWBAbstractModel,
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
	#category : #'PWBTestGenerator-DataModel-Model'
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
			'nvo_tools_file' . 'nvo_tools_ini' . 'nvo_database_transac_properties'.
			'nvo_database_base'}
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
	self flag: #todo.
	assertons := OrderedCollection new.
	self mrlReturnValues ifEmpty: [ ^ assertons ].
	self pwbParameters
		keysAndValuesDo: [ :key :value | 
			(value anySatisfy: #isPWBDataWindow)
				ifTrue: [ assertons
						add:
							(self
								ensureCreateAssertion: PWBFunctionWithDataWindowParametersUnitAssertion
								with: key
								and: value) ]
				ifFalse: [ assertons
						add:
							(self
								ensureCreateAssertion: PWBFunctionWithBasicTypesParametersUnitAssertion
								with: key
								and: value) ] ].
	^ assertons
]

{ #category : #'as yet unclassified' }
MrlBehavior >> ensureCreateAssertion: assertionClass with: timeStamp and: aCollection [
	^ assertionClass new
		pwbParameters: aCollection;
		functionUnderTest: self behaviorUnderTest;
		timestamp: timeStamp;
		behaviorAccesses:
			(self mrlInstanceVariablesAccesses
				select: [ :acc | acc instance_variable_access_timestamp = timeStamp ]);
		behaviorReturnValue:
			(self mrlReturnValues
				detect: [ :returnValue | returnValue timestamp = timeStamp ]
				ifNone: [  ]);
		yourself
]

{ #category : #'as yet unclassified' }
MrlBehavior >> generateTestCaseFromData [
	PWBTestSuite
		testCaseForFunction:
			((MooseModel root first allWithType: FamixPWBFunction)
				detect: [ :uf | uf name = self behavior_name ])
]

{ #category : #'as yet unclassified' }
MrlBehavior >> getInstanceVariableAccess: aTimestampString [
	^ self mrlInstanceVariablesAccesses
		at: aTimestampString
		ifAbsent: [  ]
]

{ #category : #initialization }
MrlBehavior >> initialize [
	super initialize.
	mrlParameters := OrderedCollection new.
	mrlReturnValues := OrderedCollection new.
	mrlInstanceVariablesAccesses := OrderedCollection new
]

{ #category : #testing }
MrlBehavior >> isPrivate [
	^ behaviorUnderTest isPrivate
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
	mrlParameters := (MrlParameter
		loadWhere: [ :mrlParameter | mrlParameter behavior_id = self behavior_id ])
		do: #loadValue
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
	^ mrlInstanceVariablesAccesses
]

{ #category : #accessing }
MrlBehavior >> mrlReturnValues [
	mrlReturnValues ifEmpty: [ self loadMrlReturnValues ].
	^ mrlReturnValues
]

{ #category : #accessing }
MrlBehavior >> pwbParameters [
	mrlParameters ifEmpty: [ self loadMrlParameters ].
	^ (mrlParameters groupedBy: #timestamp) asOrderedDictionary
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
	timestamps ifNil: [ timestamps := self pwbParameters keys ].
	^ timestamps
]
