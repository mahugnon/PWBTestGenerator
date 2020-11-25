Class {
	#name : #'MrlParameter_before_value',
	#superclass : #'MrlParameter_value',
	#category : #'PWBTestGenerator-DataModel-Model'
}

{ #category : #'as yet unclassified' }
MrlParameter_before_value class >> session [
	| session login |
	login := self login.
	session := MrlParameter_before_valueDescriptorSystem
		sessionForLogin: login.
	session login.
	^ session
]
