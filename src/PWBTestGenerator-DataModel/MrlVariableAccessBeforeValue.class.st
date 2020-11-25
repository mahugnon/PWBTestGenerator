Class {
	#name : #MrlVariableAccessBeforeValue,
	#superclass : #MrlVariableAccessValue,
	#category : #'PWBTestGenerator-DataModel-Model'
}

{ #category : #'as yet unclassified' }
MrlVariableAccessBeforeValue class >> session [
	| session login |
	login := self login.
	session := MrlVariableAccessBeforeValueDescriptorSystem
		sessionForLogin: login.
	session login.
	^ session
]
