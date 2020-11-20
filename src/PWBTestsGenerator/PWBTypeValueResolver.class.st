Class {
	#name : #PWBTypeValueResolver,
	#superclass : #Object,
	#category : #'PWBTestsGenerator-PWBTestUnitStrategy'
}

{ #category : #'as yet unclassified' }
PWBTypeValueResolver class >> accept: aTypeName [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBTypeValueResolver class >> resolveValue: aString withType: aTypeName [
	^ (self subclasses detect: [ :sub | sub accept: aTypeName ]) new
		resolve: aString
]

{ #category : #resolving }
PWBTypeValueResolver >> resolve: aString [
	
]
