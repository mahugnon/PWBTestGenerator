Class {
	#name : #NumberValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
NumberValueSolver class >> accept: aMrlParameter [
	^ #('Integer' 'Decimal' 'Int' 'Double' 'Number' 'Long')
		anySatisfy:
			[ :type | type asLowercase = aMrlParameter parameterType name asLowercase ]
]

{ #category : #printing }
NumberValueSolver class >> acceptType: aTypeName [
	^ #('Integer' 'Decimal' 'Int' 'Double' 'Number' 'Long')
		anySatisfy: [ :type | type asLowercase = aTypeName asLowercase ]
]

{ #category : #printing }
NumberValueSolver >> printValue: aString [
	^ aString
]

{ #category : #resolving }
NumberValueSolver >> rightSideOn: stream [
	^ stream
		<< focus parameter_before_value mrlValue;
		crlf
]
