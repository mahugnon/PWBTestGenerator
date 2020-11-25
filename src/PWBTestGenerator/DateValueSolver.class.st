Class {
	#name : #DateValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
DateValueSolver class >> accept: aTypeName [
	^ aTypeName asLowercase = 'date'
]

{ #category : #resolving }
DateValueSolver >> resolve: aString [
	^ 'date("' , aString , '")'
]
