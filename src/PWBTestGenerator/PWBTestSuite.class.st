Class {
	#name : #PWBTestSuite,
	#superclass : #Object,
	#instVars : [
		'behaviorUnderTest',
		'pwbunitTestClass'
	],
	#category : #'PWBTestGenerator-PWBTestSuite'
}

{ #category : #'as yet unclassified' }
PWBTestSuite class >> generateForModel: aFamixPWBModel in: aFolder [
	aFamixPWBModel getBusinessRuleFunctions values flatten
		do:
			[ :aFamixPWBFunction | self testCaseForFunction: aFamixPWBFunction in: aFolder ]
]

{ #category : #tests }
PWBTestSuite class >> testCaseForFunction: aFamixPWBFunction in: aFolder [
	aFamixPWBFunction isPrivate
		ifTrue: [ ^ self ].
	^ self new
		behaviorUnderTest: aFamixPWBFunction;
		printPWBScript: aFolder
]

{ #category : #'as yet unclassified' }
PWBTestSuite class >> updateData: aBuilder [
	<worldMenu>
	(aBuilder item: #GeneratePWBTests)
		parent: #PWBTools;
		help: 'Generate PBUnit test classes';
		label: 'GeneratePWBTests';
		action: [ | folder |
			PharoDatabaseAccessor DefaultDriver: P3DatabaseDriver.
			MooseModel root
				ifEmpty: [ self error: 'You must install a Powerbuilder model' ].
			folder := UITheme builder
				chooseDirectory: 'Choose the destination folder'.
			folder
				ifNotNil: [ self generateForModel: MooseModel root first in: folder ] ]
]

{ #category : #accessing }
PWBTestSuite >> behaviorUnderTest [
	^ behaviorUnderTest
]

{ #category : #accessing }
PWBTestSuite >> behaviorUnderTest: anObject [
	behaviorUnderTest := anObject.
	pwbunitTestClass := PWBTestMethod
		unitTestForFunction: behaviorUnderTest
]

{ #category : #tests }
PWBTestSuite >> fileDeclaredType [
	^ String
		streamContents: [ :stream | 
			stream
				<< 'global type';
				space;
				<< self name;
				space;
				<< 'from';
				space;
				<< 'testcase';
				crlf;
				<< 'event';
				space;
				<< self testCaseName;
				space;
				<< '()';
				crlf;
				<< 'end type';
				crlf;
				<< 'global';
				space;
				<< self name;
				space;
				<< self name;
				crlf ]
]

{ #category : #tests }
PWBTestSuite >> forward [
	^ String
		streamContents: [ :stream | 
			stream
				<< 'forward';
				crlf;
				<< 'global type ';
				<< self name;
				space;
				<< 'from';
				space;
				<< 'testcase';
				crlf;
				<< 'end type';
				crlf;
				<< 'end forward';
				crlf ]
]

{ #category : #tests }
PWBTestSuite >> name [
	^ 'test_' , behaviorUnderTest name , '_case'
]

{ #category : #tests }
PWBTestSuite >> onCreate [
	^ String
		streamContents: [ :stream | 
			stream
				<< 'on';
				space;
				<< self name;
				<< '.create';
				crlf;
				<< 'call super::create';
				crlf;
				<< 'end on' ]
]

{ #category : #tests }
PWBTestSuite >> onDestroy [
	^ String
		streamContents: [ :stream | 
			stream
				<< 'on';
				space;
				<< self name;
				<< '.destroy';
				crlf;
				<< 'call super::destroy';
				crlf;
				<< 'end on' ]
]

{ #category : #printing }
PWBTestSuite >> printPWBScript: aFolder [
	pwbunitTestClass hasAssertions
		ifFalse: [ ^ self ].
	^ (aFolder asFileReference / (self name , '.sru'))
		ensureCreateFile;
		writeStreamDo: [ :stream | self printPWBScriptOn: stream ]
]

{ #category : #printing }
PWBTestSuite >> printPWBScriptOn: stream [
	stream
		<< self testFileHeader;
		<< self forward;
		<< self fileDeclaredType;
		crlf.
	pwbunitTestClass printPWBScriptOn: stream.
	stream crlf.
	^ stream
		<< self onCreate;
		crlf;
		<< self onDestroy
]

{ #category : #accessing }
PWBTestSuite >> pwbunitTestClass [
	^ pwbunitTestClass
]

{ #category : #accessing }
PWBTestSuite >> pwbunitTestClass: anObject [
	pwbunitTestClass := anObject
]

{ #category : #tests }
PWBTestSuite >> testCaseName [
	^ 'test_' , behaviorUnderTest name
]

{ #category : #tests }
PWBTestSuite >> testFileHeader [
	^ String
		streamContents: [ :stream | 
			stream
				nextPut: $$;
				<< 'PBExportHeader';
				<< $$;
				<< self name;
				<< '.sru';
				crlf ]
]
