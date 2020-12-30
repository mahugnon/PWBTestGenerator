Class {
	#name : #PWBTestSuiteSimple,
	#superclass : #Object,
	#instVars : [
		'mrlBehavior'
	],
	#category : #'PWBTestGenerator-PWBTestSuite'
}

{ #category : #'as yet unclassified' }
PWBTestSuiteSimple class >> generateForModel: aFamixPWBModel in: aFolder [
	aFamixPWBModel getBusinessRuleFunctions values flatten
		do:
			[ :aFamixPWBFunction | self testCaseForFunction: aFamixPWBFunction in: aFolder ]
]

{ #category : #tests }
PWBTestSuiteSimple class >> testCaseForFunction: aFamixPWBBehavior in: aFolder [
	| mrlBehavior |
	aFamixPWBBehavior isPrivate
		ifTrue: [ ^ self ].
	mrlBehavior := (MrlBehavior
		loadWithMrlParameterAndMrlReturnValuesWhere: [ :function | 
			function behavior_name = aFamixPWBBehavior name
				AND: [ function pwb_object = aFamixPWBBehavior parentType name ] ])
		anyOne.
	mrlBehavior behaviorUnderTest: aFamixPWBBehavior.
	^ self new
		mrlBehavior: mrlBehavior;
		printPWBScript: aFolder
]

{ #category : #'as yet unclassified' }
PWBTestSuiteSimple class >> updateData: aBuilder [
	<worldMenu>
	(aBuilder item: #GeneratePWBTestSimple)
		parent: #PWBTools;
		help: 'Generate PBUnit test classes';
		label: 'GeneratePWBTestSimple';
		action: [ | folder |
			PharoDatabaseAccessor DefaultDriver: P3DatabaseDriver.
			MooseModel root
				ifEmpty: [ self error: 'You must install a Powerbuilder model' ].
			folder := UITheme builder
				chooseDirectory: 'Choose the destination folder'.
			folder
				ifNotNil: [ self generateForModel: MooseModel root first in: folder ] ]
]

{ #category : #tests }
PWBTestSuiteSimple >> fileDeclaredTypeOn: stream [
	stream
		<< 'global type';
		space;
		<< 'test_';
		<< mrlBehavior behavior_name;
		<< '_case';
		space;
		<< 'from';
		space;
		<< 'testcase';
		crlf;
		<< 'event';
		space;
		<< 'test_';
		<< mrlBehavior behavior_name;
		space;
		<< '()';
		crlf;
		<< 'end type';
		crlf;
		<< 'global';
		space;
		<< 'test_';
		<< mrlBehavior behavior_name;
		<< '_case';
		space;
		<< 'test_';
		<< mrlBehavior behavior_name;
		<< '_case';
		crlf
]

{ #category : #tests }
PWBTestSuiteSimple >> forwardOn: stream [
	stream
		<< 'forward';
		crlf;
		<< 'global type ';
		<< 'test_';
		<< mrlBehavior behavior_name;
		<< '_case';
		space;
		<< 'from';
		space;
		<< 'testcase';
		crlf;
		<< 'end type';
		crlf;
		<< 'end forward';
		crlf
]

{ #category : #accessors }
PWBTestSuiteSimple >> mrlBehavior: aMrlBehavior [ 
	mrlBehavior := aMrlBehavior
]

{ #category : #tests }
PWBTestSuiteSimple >> onCreateOn: stream [
	stream
		<< 'on';
		space;
		<< 'test_';
		<< mrlBehavior behavior_name;
		<< '_case';
		<< '.create';
		crlf;
		<< 'call super::create';
		crlf;
		<< 'end on'
]

{ #category : #tests }
PWBTestSuiteSimple >> onDestroyOn: stream [
	stream
		<< 'on';
		space;
		<< 'test_';
		<< mrlBehavior behavior_name;
		<< '_case';
		<< '.destroy';
		crlf;
		<< 'call super::destroy';
		crlf;
		<< 'end on'
]

{ #category : #printing }
PWBTestSuiteSimple >> printPWBScript: aFolder [
	| testCreator |
	testCreator := PWBUnitTestSimple new mrlBehavior: mrlBehavior.
	mrlBehavior hasAssertions
		ifFalse: [ ^ self ].
	^ (aFolder asFileReference
		/ ('test_' , mrlBehavior behavior_name , '_case' , '.sru'))
		ensureCreateFile;
		writeStreamDo: [ :stream | 
			self testFileHeaderOn: stream.
			self forwardOn: stream.
			self fileDeclaredTypeOn: stream.
			stream crlf.
			testCreator printPWBScriptOn: stream.
			stream crlf.
			self onCreateOn: stream.
			stream crlf.
			self onDestroyOn: stream ]
]

{ #category : #tests }
PWBTestSuiteSimple >> testFileHeaderOn: stream [
	stream
		nextPut: $$;
		<< 'PBExportHeader';
		<< $$;
		<< 'test_';
		<< mrlBehavior behavior_name;
		<< '_case';
		<< '.sru';
		crlf
]
