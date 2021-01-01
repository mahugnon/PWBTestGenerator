Class {
	#name : #PWBTestGeneratorSimpleTest,
	#superclass : #TestCase,
	#instVars : [
		'stream',
		'testClass',
		'mrlBehavior'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #accessing }
PWBTestGeneratorSimpleTest >> script [
	^ stream contents copyReplaceAll: String crlf with: String cr
]

{ #category : #running }
PWBTestGeneratorSimpleTest >> setUp [
	stream := WriteStream on: String new.
	testClass := PWBTestGeneratorSimple new.
	mrlBehavior := MrlBehavior new behavior_name: 'testFunction'.
	testClass mrlBehavior: mrlBehavior
]

{ #category : #tests }
PWBTestGeneratorSimpleTest >> testFileDeclaredTypeOn [
	testClass fileDeclaredTypeOn: stream.
	self
		assert: self script
		equals:
			'global type test_testFunction_case from testcase
event test_testFunction ()
end type
global test_testFunction_case test_testFunction_case
'
]

{ #category : #tests }
PWBTestGeneratorSimpleTest >> testForwardOn [
	testClass forwardOn: stream.
	self
		assert: self script
		equals:
			'forward
global type test_testFunction_case from testcase
end type
end forward
'
]

{ #category : #tests }
PWBTestGeneratorSimpleTest >> testOnCreateOn [
	testClass onCreateOn: stream.
	self
		assert: self script
		equals:
			'on test_testFunction_case.create
call super::create
end on'
]

{ #category : #tests }
PWBTestGeneratorSimpleTest >> testOnDestroyOn [
	testClass onDestroyOn: stream.
	self
		assert: self script
		equals:
			'on test_testFunction_case.destroy
call super::destroy
end on'
]

{ #category : #tests }
PWBTestGeneratorSimpleTest >> testTestFileHeaderOn [
	testClass testFileHeaderOn: stream.
	self
		assert: self script
		equals:
			'$PBExportHeader$test_testFunction_case.sru
'
]
