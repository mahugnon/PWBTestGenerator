Class {
	#name : #PWBTypeValueSolver,
	#superclass : #Object,
	#instVars : [
		'focus',
		'varName',
		'tag'
	],
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
PWBTypeValueSolver class >> accept: aTypeName [
	^ self subclassResponsibility
]

{ #category : #printing }
PWBTypeValueSolver class >> acceptType: aTypeName [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBTypeValueSolver class >> printParameter: aMrlParameter on: stream [
	^ aMrlParameter parameter_before_value
		ifNotNil: [ (self subclasses detect: [ :sub | sub accept: aMrlParameter ]) new
				printParameter: aMrlParameter
				on: stream ]
		ifNil:
			[ NilValueSolver new printParameter: aMrlParameter on: stream ]
]

{ #category : #printing }
PWBTypeValueSolver class >> printValue: aValue ofType: aTypeName [
	^ aValue
		ifNotNil: [ (self subclasses detect: [ :sub | sub acceptType: aTypeName ]) new
				printValue: aValue ]
		ifNil: [ NilValueSolver new printValue: aValue ]
]

{ #category : #'as yet unclassified' }
PWBTypeValueSolver class >> resolveValue: aMrlParameter [
	^ aMrlParameter parameter_before_value
		ifNotNil: [ (self subclasses detect: [ :sub | sub accept: aMrlParameter ]) new
				resolve: aMrlParameter ]
		ifNil: [ self handleNilValue: aMrlParameter ]
]

{ #category : #resolving }
PWBTypeValueSolver >> leftSideOn: stream [
	varName := 'l'
		, (focus parameter_name copyFrom: 2 to: focus parameter_name size).
	^ stream
		<< varName;
		space;
		<< '=';
		space
]

{ #category : #resolving }
PWBTypeValueSolver >> printParameter: aMrlParameter on: stream [
	focus := aMrlParameter.
	self leftSideOn: stream.
	self rightSideOn: stream.
	^ stream
]

{ #category : #printing }
PWBTypeValueSolver >> printValue: aString [
	self subclassResponsibility
]

{ #category : #resolving }
PWBTypeValueSolver >> rightSideOn: stream [
	self subclassResponsibility
]
