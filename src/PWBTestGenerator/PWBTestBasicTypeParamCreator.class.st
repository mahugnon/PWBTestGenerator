Class {
	#name : #PWBTestBasicTypeParamCreator,
	#superclass : #PWBTestParameterCreator,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #visiting }
PWBTestBasicTypeParamCreator class >> accept: aMrlParam [
	^ aMrlParam isPWBDataWindow not
]

{ #category : #'as yet unclassified' }
PWBTestBasicTypeParamCreator >> param: param on: stream [
	PWBVariableInitializer printParameter: param on: stream
]
