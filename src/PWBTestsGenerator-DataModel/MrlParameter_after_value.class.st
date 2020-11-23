Class {
	#name : #'MrlParameter_after_value',
	#superclass : #'MrlParameter_value',
	#category : #'PWBTestsGenerator-DataModel-Model'
}

{ #category : #'as yet unclassified' }
MrlParameter_after_value class >> session [
	| session login |
	login := self login.
	session := MrlParameter_after_valueDescriptorSystem
		sessionForLogin: login.
	session login.
	^ session
]
