Class {
	#name : #MrlBehavior,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'behaviorUnderTest',
		'behavior_name',
		'pwb_object',
		'behavior_id',
		'mrlParameters',
		'mrlReturnValues',
		'mrlInstanceVariablesAccesses',
		'currentTimestamp',
		'mrlBehaviorDatas'
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

{ #category : #adding }
MrlBehavior >> addAllMrlParameters: aCollection [
	mrlParameters addAll: aCollection
]

{ #category : #adding }
MrlBehavior >> addAllMrlReturnValues: aCollection [
	mrlReturnValues addAll: aCollection
]

{ #category : #'as yet unclassified' }
MrlBehavior >> addMrlInstanceVariablesAccess: aMrlInstanceVariablesAccess [
	mrlInstanceVariablesAccesses add: aMrlInstanceVariablesAccess
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
	self setOriginalParameters.
	self setInstanceVariableAccesModel
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
MrlBehavior >> createMrlBehaviorDatas [
	| timestamps |
	timestamps := mrlParameters , mrlInstanceVariablesAccesses
		, mrlReturnValues collectAsSet: #timestamp.
	mrlBehaviorDatas := timestamps
		collect: [ :time | 
			MrlBehaviorData new
				timestamp: time;
				mrlParameters: (self mrlParameters select: [ :each | each timestamp = time ]);
				mrlInstanceVariablesAccesses:
					(self mrlInstanceVariablesAccesses
						select: [ :each | each timestamp = time ]);
				mrlReturnValues: (self mrlReturnValues select: [ :each | each timestamp = time ]);
				yourSelf ].
	^ mrlBehaviorDatas
]

{ #category : #comparing }
MrlBehavior >> equals: anObject [
	^ self behavior_name = anObject behavior_name
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

{ #category : #accessing }
MrlBehavior >> mrlBehaviorDatas [
	mrlBehaviorDatas isEmptyOrNil
		ifTrue: [ self createMrlBehaviorDatas.
			self removeRedundance ].
	^ mrlBehaviorDatas
]

{ #category : #accessing }
MrlBehavior >> mrlBehaviorDatas: anUndefinedObject [ 
	mrlBehaviorDatas := anUndefinedObject
]

{ #category : #'as yet unclassified' }
MrlBehavior >> mrlInstanceVariablesAccesses [
	^ mrlInstanceVariablesAccesses
]

{ #category : #accessing }
MrlBehavior >> mrlParameters [
	^ mrlParameters
]

{ #category : #accessing }
MrlBehavior >> mrlReturnValues [
	mrlReturnValues ifEmpty: [ self loadMrlReturnValues ].
	^ mrlReturnValues
]

{ #category : #'as yet unclassified' }
MrlBehavior >> populateMrlDatas [
	mrlParameters := OrderedCollection new.
	mrlReturnValues := OrderedCollection new.
	mrlInstanceVariablesAccesses := OrderedCollection new.
	mrlBehaviorDatas
		do: [ :data | 
			mrlParameters addAll: data mrlParameters.
			mrlReturnValues addAll: data mrlReturnValues.
			mrlInstanceVariablesAccesses
				addAll: data mrlInstanceVariablesAccesses ]
]

{ #category : #accessing }
MrlBehavior >> pwbParameters [
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

{ #category : #removing }
MrlBehavior >> removeRedundance [
	| result |
	result := OrderedCollection new.
	mrlBehaviorDatas
		do: [ :each | 
			result
				detect: [ :data | data equals: each ]
				ifNone: [ result add: each ] ].
	mrlBehaviorDatas := result
]

{ #category : #accessing }
MrlBehavior >> returnType [
	^ behaviorUnderTest returnType name
]

{ #category : #api }
MrlBehavior >> setInstanceVariableAccesModel [
	self mrlInstanceVariablesAccesses
		do: [ :each | each mooseModel: behaviorUnderTest mooseModel ]
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
	^ self mrlBehaviorDatas collectAsSet: #timestamp
]
