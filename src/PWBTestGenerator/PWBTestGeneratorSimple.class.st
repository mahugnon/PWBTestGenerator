Class {
	#name : #PWBTestGeneratorSimple,
	#superclass : #Object,
	#instVars : [
		'mrlBehavior'
	],
	#category : #'PWBTestGenerator-Core'
}

{ #category : #'as yet unclassified' }
PWBTestGeneratorSimple class >> generateForModel: aFamixPWBModel in: aFolder [
	MrlBehavior loadAll
		do: [ :aMrlBehavior | 
			| behaviorToTest |
			behaviorToTest := aFamixPWBModel allMethods
				detect: [ :m | m name = aMrlBehavior behavior_name ].
			behaviorToTest isPrivate
				ifTrue: [ ^ self ].
			aMrlBehavior loadParametersAccessesReturn.
			aMrlBehavior behaviorUnderTest: behaviorToTest.
			self new
				mrlBehavior: aMrlBehavior;
				printPWBScript: aFolder ]
		displayingProgress: [ :aBehavior | aBehavior behavior_name ]
]

{ #category : #'as yet unclassified' }
PWBTestGeneratorSimple class >> updateData: aBuilder [
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
PWBTestGeneratorSimple >> fileDeclaredTypeOn: stream [
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
PWBTestGeneratorSimple >> forwardOn: stream [
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
PWBTestGeneratorSimple >> mrlBehavior: aMrlBehavior [ 
	mrlBehavior := aMrlBehavior
]

{ #category : #tests }
PWBTestGeneratorSimple >> onCreateOn: stream [
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
PWBTestGeneratorSimple >> onDestroyOn: stream [
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
PWBTestGeneratorSimple >> printPWBScript: aFolder [
	mrlBehavior hasAssertions
		ifFalse: [ ^ self ].
	^ (aFolder asFileReference
		/ ('test_' , mrlBehavior behavior_name , '_case_generated' , '.sru'))
		ensureCreateFile;
		writeStreamDo: [ :stream | 
			self testFileHeaderOn: stream.
			self forwardOn: stream.
			self fileDeclaredTypeOn: stream.
			stream crlf.
			PWBTestEventGenerator new
				mrlBehavior: mrlBehavior;
				printPWBScriptOn: stream.
			stream crlf.
			self onCreateOn: stream.
			stream crlf.
			self onDestroyOn: stream ]
]

{ #category : #tests }
PWBTestGeneratorSimple >> testFileHeaderOn: stream [
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
