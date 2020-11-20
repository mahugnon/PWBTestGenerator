Class {
	#name : #'MrlParameter_after_value',
	#superclass : #'MrlParameter_value',
	#category : #'PWBTestsGenerator-DataModel'
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
