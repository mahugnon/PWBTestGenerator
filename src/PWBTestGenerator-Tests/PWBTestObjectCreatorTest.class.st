Class {
	#name : #PWBTestObjectCreatorTest,
	#superclass : #TestCase,
	#instVars : [
		'stream'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #accessing }
PWBTestObjectCreatorTest >> script [
	^ stream contents copyReplaceAll: String crlf with: String cr
]

{ #category : #running }
PWBTestObjectCreatorTest >> setUp [
	stream := WriteStream on: String new
]

{ #category : #tests }
PWBTestObjectCreatorTest >> testPWBTestGlobalFunctionObjectCreator [
	self
		assert: (PWBTestGlobalFunctionObjectCreator accept: 'f_testFunction').
	PWBTestGlobalFunctionObjectCreator new
		objectNamed: 'f_testFunction'
		on: stream.
	self assert: self script isEmpty
]

{ #category : #tests }
PWBTestObjectCreatorTest >> testPWBTestUserObjectCreator [
	self assert: (PWBTestUserObjectCreator accept: 'uo_test').
	PWBTestUserObjectCreator new objectNamed: 'uo_test' on: stream.
	self
		assert: self script
		equals:
		'uo_test luo_test
luo_test = create uo_test
'
]
