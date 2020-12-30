Class {
	#name : #PWBVariableInitializer,
	#superclass : #Object,
	#instVars : [
		'focus',
		'varName',
		'tag'
	],
	#category : #'PWBTestGenerator-VariableUtilities'
}

{ #category : #'as yet unclassified' }
PWBVariableInitializer class >> accept: aTypeName [
	^ self subclassResponsibility
]

{ #category : #printing }
PWBVariableInitializer class >> acceptType: aTypeName [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBVariableInitializer class >> printParameter: aMrlParameter on: stream [
	^ (aMrlParameter parameter_before_value isNil
		or: [ aMrlParameter parameter_before_value mrlValue isNil ])
		ifTrue:
			[ NilVariableInitializer new printParameter: aMrlParameter on: stream ]
		ifFalse: [ (self subclasses detect: [ :sub | sub accept: aMrlParameter ]) new
				printParameter: aMrlParameter
				on: stream ]
]

{ #category : #printing }
PWBVariableInitializer class >> printValue: aValue ofType: aTypeName [
	^ aValue
		ifNotNil: [ (self subclasses detect: [ :sub | sub acceptType: aTypeName ]) new
				printValue: aValue ]
		ifNil: [ NilVariableInitializer new printValue: aValue ]
]

{ #category : #resolving }
PWBVariableInitializer >> leftSideOn: stream [
	varName := 'l'
		, (focus parameter_name copyFrom: 2 to: focus parameter_name size).
	^ stream
		<< varName;
		space;
		<< '=';
		space
]

{ #category : #resolving }
PWBVariableInitializer >> printParameter: aMrlParameter on: stream [
	focus := aMrlParameter.
	self leftSideOn: stream.
	self rightSideOn: stream.
	^ stream
]

{ #category : #printing }
PWBVariableInitializer >> printValue: aString [
	self subclassResponsibility
]

{ #category : #resolving }
PWBVariableInitializer >> rightSideOn: stream [
	self subclassResponsibility
]
