Class {
	#name : #MrlBehaviorData,
	#superclass : #Object,
	#instVars : [
		'mrlParameters',
		'mrlReturnValues',
		'timestamp',
		'mrlInstanceVariablesAccesses'
	],
	#category : #'PWBTestGenerator-DataModel-Model'
}

{ #category : #accessing }
MrlBehaviorData >> equals: aMrlBehaviorData [
	| boolean |
	(self mrlParameters size = aMrlBehaviorData mrlParameters size
		and: [ self mrlInstanceVariablesAccesses size
				= aMrlBehaviorData mrlInstanceVariablesAccesses size
				and: [ self mrlReturnValues size = aMrlBehaviorData mrlReturnValues size ] ])
		ifFalse: [ ^ false ].
	boolean := true.
	1 to: self mrlParameters size do: [ :iter | 
		boolean := (self mrlParameters at: iter)
			equals: (aMrlBehaviorData mrlParameters at: iter) ].
	1 to: self mrlInstanceVariablesAccesses size do: [ :iter | 
		boolean := (self mrlInstanceVariablesAccesses at: iter)
			equals: (aMrlBehaviorData mrlInstanceVariablesAccesses at: iter) ].
	1 to: self mrlReturnValues size do: [ :iter | 
		boolean := (self mrlReturnValues at: iter)
			equals: (aMrlBehaviorData mrlReturnValues at: iter) ].
	^ boolean
]

{ #category : #accessing }
MrlBehaviorData >> mrlInstanceVariablesAccesses [
	^ mrlInstanceVariablesAccesses
]

{ #category : #accessing }
MrlBehaviorData >> mrlInstanceVariablesAccesses: anObject [
	mrlInstanceVariablesAccesses := anObject
]

{ #category : #accessing }
MrlBehaviorData >> mrlParameters [
	^ mrlParameters
]

{ #category : #accessing }
MrlBehaviorData >> mrlParameters: anObject [
	mrlParameters := anObject
]

{ #category : #accessing }
MrlBehaviorData >> mrlReturnValues [
	^ mrlReturnValues
]

{ #category : #accessing }
MrlBehaviorData >> mrlReturnValues: anObject [
	mrlReturnValues := anObject
]

{ #category : #accessing }
MrlBehaviorData >> timestamp [
	^ timestamp
]

{ #category : #accessing }
MrlBehaviorData >> timestamp: anObject [
	timestamp := anObject
]
