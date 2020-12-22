Class {
	#name : #NumberVariableInitializer,
	#superclass : #PWBVariableInitializer,
	#category : #'PWBTestGenerator-VariableInitializers'
}

{ #category : #'as yet unclassified' }
NumberVariableInitializer class >> accept: aMrlParameter [
	^ #('Integer' 'Decimal' 'Int' 'Double' 'Number' 'Long')
		anySatisfy:
			[ :type | type asLowercase = aMrlParameter parameterType name asLowercase ]
]

{ #category : #printing }
NumberVariableInitializer class >> acceptType: aTypeName [
	^ #('Integer' 'Decimal' 'Int' 'Double' 'Number' 'Long')
		anySatisfy: [ :type | type asLowercase = aTypeName asLowercase ]
]

{ #category : #printing }
NumberVariableInitializer >> printValue: aString [
	^ aString
]

{ #category : #resolving }
NumberVariableInitializer >> rightSideOn: stream [
	^ stream
		<< focus parameter_before_value mrlValue;
		crlf
]
