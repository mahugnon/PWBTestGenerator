Class {
	#name : #PWBTestCase,
	#superclass : #Object,
	#instVars : [
		'testUnits',
		'behaviorUnderTest',
		'globalTypes'
	],
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #'as yet unclassified' }
PWBTestCase class >> generateForModel: aFamixPWBModel in: aFolder [
	aFamixPWBModel getBusinessRuleFunctions values flatten
		do:
			[ :aFamixPWBFunction | self testCaseForFunction: aFamixPWBFunction in: aFolder ]
]

{ #category : #tests }
PWBTestCase class >> testCaseForFunction: aFamixPWBFunction [
	^ self new
		behaviorUnderTest: aFamixPWBFunction;
		printPWBDeclarationScript
]

{ #category : #tests }
PWBTestCase class >> testCaseForFunction: aFamixPWBFunction in: aFolder [
	^ self new
		behaviorUnderTest: aFamixPWBFunction;
		printPWBScript: aFolder
]

{ #category : #'as yet unclassified' }
PWBTestCase class >> updateData: aBuilder [
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

{ #category : #adding }
PWBTestCase >> addUnitTest: aUnitTest [
	testUnits add: aUnitTest
]

{ #category : #accessing }
PWBTestCase >> behaviorUnderTest [
	^ behaviorUnderTest
]

{ #category : #accessing }
PWBTestCase >> behaviorUnderTest: anObject [
	behaviorUnderTest := anObject.
	self
		addUnitTest: (PWBUnitTest unitTestForFunction: behaviorUnderTest)
]

{ #category : #tests }
PWBTestCase >> fileDeclaredType [
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
PWBTestCase >> forword [
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

{ #category : #printing }
PWBTestCase >> initialize [
	super initialize.
	testUnits := OrderedCollection new
]

{ #category : #tests }
PWBTestCase >> name [
	^ 'test_' , behaviorUnderTest name , '_case'
]

{ #category : #tests }
PWBTestCase >> onCreate [
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
PWBTestCase >> onDestroy [
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
PWBTestCase >> printPWBScript: aFolder [
	^ (aFolder asFileReference / (self name , '.sru'))
		ensureCreateFile;
		writeStreamDo: [ :stream | 
			stream
				<< self testFileHeader;
				<< self forword;
				<< self fileDeclaredType;
				crlf.
			testUnits
				do: [ :units | 
					units printPWBScriptOn: stream.
					stream crlf ].
			stream
				<< self onCreate;
				crlf;
				<< self onDestroy ]
]

{ #category : #tests }
PWBTestCase >> testCaseName [
	^ 'test_' , behaviorUnderTest name
]

{ #category : #tests }
PWBTestCase >> testFileHeader [
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