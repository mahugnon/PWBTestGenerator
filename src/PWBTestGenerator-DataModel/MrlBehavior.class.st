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
		'mrlInstanceVariablesAccesses',
		'taskList'
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
	^ (super loadAll
		reject: [ :each | 
			{'nvo_mdb_rdg' . 'nvo_config' . 'nvo_database_manager'.
			'nvo_tools_file' . 'nvo_tools_ini' . 'nvo_database_transac_properties'.
			'nvo_database_base'}
				anySatisfy: [ :aString | aString = each pwb_object ] ])
	"	do: #loadParametersAccessesReturn
		displayingProgress: [ :aBehavior | 'loading ' , aBehavior behavior_name ]"
]

{ #category : #accessing }
MrlBehavior class >> loadAllWithMrlParameterAndMrlReturnValues [
	^ self loadAll do: #loadParametersAccessesReturn
]

{ #category : #accessing }
MrlBehavior class >> loadAllWithMrlParameters [
	^ self loadAll do: #loadMrlParameters
]

{ #category : #accessing }
MrlBehavior class >> loadWithMrlParameterAndMrlReturnValuesWhere: aBlock [
	^ (self loadWhere: aBlock) do: #loadParametersAccessesReturn
]

{ #category : #'as yet unclassified' }
MrlBehavior >> addAccessBaseAssertion: aTimeStampString [
	| accesses |
	accesses := self mrlInstanceVariablesAccesses
		select: [ :acc | acc instance_variable_access_timestamp = aTimeStampString ].
	accesses ifEmpty: [ ^ taskList ].
	taskList add: (PWBAccessBasedAssertion assertionFor: accesses).
	^ taskList
]

{ #category : #adding }
MrlBehavior >> addAllMrlParameters: aCollection [
	mrlParameters addAll: aCollection
]

{ #category : #adding }
MrlBehavior >> addAllMrlReturnValues: aCollection [
	mrlReturnValues addAll: aCollection
]

{ #category : #'as yet unclassified' }
MrlBehavior >> addBehaviorInvocation: parameters [
	taskList
		add:
			(PWBBehaviorInvocation new
				behaviorUnderTest: self behaviorUnderTest;
				pwbParameters: parameters;
				yourself).
	^ taskList
]

{ #category : #adding }
MrlBehavior >> addMrlParameter: aMrlParameter [
	mrlParameters add: aMrlParameter
]

{ #category : #adding }
MrlBehavior >> addMrlReturnValue: aMrlReturnValue [
	mrlReturnValues add: aMrlReturnValue
]

{ #category : #'as yet unclassified' }
MrlBehavior >> addReturnBaseAssertionFor: aCollection at: aTimeStampString [
	| return |
	return := self mrlReturnValues
		detect: [ :returnValue | returnValue timestamp = aTimeStampString ]
		ifNone: [  ].
	return ifNil: [ ^ taskList ].
	taskList
		add:
			((PWBAbstractReturnBaseUnitAssertion assertionFor: aCollection) new
				behaviorUnderTest: self behaviorUnderTest;
				behaviorReturnValue: return).
	^ taskList
]

{ #category : #'as yet unclassified' }
MrlBehavior >> addTestCaseInitialize: aCollection [
	taskList
		add: (PWBTestCaseInitializer testCaseInitializerFor: aCollection)
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
MrlBehavior >> createTaskWithAccessStrategy [
	| timeStamps |
	timeStamps := self mrlInstanceVariablesAccesses
		collectAsSet: #timeStamp.
	timeStamps
		do: [ :timestamp | 
			self addTestCaseInitialize: #().
			self addBehaviorInvocation: #().
			self addReturnBaseAssertionFor: #() at: timestamp.
			self addAccessBaseAssertion: timestamp ]
]

{ #category : #'as yet unclassified' }
MrlBehavior >> createTaskWithParamStrategy [
	self pwbParameters
		keysAndValuesDo: [ :timestamp :parameters | 
			self addTestCaseInitialize: parameters.
			self addBehaviorInvocation: parameters.
			self addReturnBaseAssertionFor: parameters at: timestamp.
			self addAccessBaseAssertion: timestamp ]
]

{ #category : #'as yet unclassified' }
MrlBehavior >> createTaskWithReturnStrategy [
	| timeStamps |
	timeStamps := self mrlReturnValues collectAsSet: #timestamp.
	timeStamps
		do: [ :timestamp | 
			self addTestCaseInitialize: #().
			self addBehaviorInvocation: #().
			self addReturnBaseAssertionFor: #() at: timestamp ]
]

{ #category : #'as yet unclassified' }
MrlBehavior >> createTestGenerationTask [
	self hasAssertions
		ifFalse: [ ^ taskList ].
	TaskListStrategy apply: self.
	^ taskList
]

{ #category : #'as yet unclassified' }
MrlBehavior >> hasAssertions [
	^ self mrlReturnValues isNotEmpty
		or: [ self mrlInstanceVariablesAccesses isNotEmpty ]
]

{ #category : #initialization }
MrlBehavior >> initialize [
	super initialize.
	mrlParameters := OrderedCollection new.
	mrlReturnValues := OrderedCollection new.
	mrlInstanceVariablesAccesses := OrderedCollection new.
	taskList := OrderedCollection new
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
MrlBehavior >> loadMrlReturnValues [
	self
		addAllMrlReturnValues:
			(MrlReturnValue
				loadWhere: [ :mrlReturnValue | mrlReturnValue behavior_id = self behavior_id ])
]

{ #category : #'as yet unclassified' }
MrlBehavior >> loadParametersAccessesReturn [
	self
		loadMrlParameters;
		loadMrlInstanceVariablesAccesses;
		loadMrlReturnValues
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
