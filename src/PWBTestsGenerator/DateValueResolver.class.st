Class {
	#name : #DateValueResolver,
	#superclass : #PWBTypeValueResolver,
	#category : #'PWBTestsGenerator-PWBTestUnitStrategy'
}

{ #category : #'as yet unclassified' }
DateValueResolver class >> accept: aTypeName [
	^ aTypeName asLowercase = 'date'
]

{ #category : #resolving }
DateValueResolver >> resolve: aString [
	^ 'date("' , aString , '")'
]
