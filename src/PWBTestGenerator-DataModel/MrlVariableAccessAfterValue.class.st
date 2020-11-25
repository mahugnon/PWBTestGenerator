Class {
	#name : #MrlVariableAccessAfterValue,
	#superclass : #MrlVariableAccessValue,
	#category : #'PWBTestGenerator-DataModel-Model'
}

{ #category : #'as yet unclassified' }
MrlVariableAccessAfterValue class >> session [
	| session login |
	login := self login.
	session := MrlVariableAccessAfterValueDescriptorSystem
		sessionForLogin: login.
	session login.
	^ session
]