Class {
	#name : #PWBSmokeTestGenerator,
	#superclass : #Object,
	#instVars : [
		'majorObject'
	],
	#category : #'PWBTestGenerator-SmokeTests'
}

{ #category : #'as yet unclassified' }
PWBSmokeTestGenerator class >> generateForModel: aFamixPWBModel in: aFolder [
	(aFamixPWBModel allWithType: FamixPWBWindow)
		, (aFamixPWBModel allWithType: FamixPWBUserObject)
		do: [ :major | 
			major methods isEmpty
				ifFalse: [ self new
						majorObject: major;
						printPWBScript: aFolder asFileReference ] ]
		displayingProgress: [ :major | major name ]
]

{ #category : #tests }
PWBSmokeTestGenerator >> declarePBUnitTestsOn: stream [
	majorObject behaviorToTest
		do: [ :behavior | 
			stream
				<< 'event';
				space;
				<< 'test_';
				<< behavior name;
				<< '_smoke_generated';
				space;
				<< '()';
				crlf ]
]

{ #category : #tests }
PWBSmokeTestGenerator >> fileDeclaredTypeOn: stream [
	stream
		<< 'global type';
		space;
		<< 'test_';
		<< majorObject name;
		<< '_case_generated';
		space;
		<< 'from';
		space;
		<< 'testcase';
		crlf.
	self declarePBUnitTestsOn: stream.
	stream
		<< 'end type';
		crlf;
		<< 'global';
		space;
		<< 'test_';
		<< majorObject name;
		<< '_case_generated';
		space;
		<< 'test_';
		<< majorObject name;
		<< '_case_generated';
		crlf
]

{ #category : #tests }
PWBSmokeTestGenerator >> forwardOn: stream [
	stream
		<< 'forward';
		crlf;
		<< 'global type ';
		<< 'test_';
		<< majorObject name;
		<< '_case_generated';
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

{ #category : #accessing }
PWBSmokeTestGenerator >> majorObject [
	^ majorObject
]

{ #category : #accessing }
PWBSmokeTestGenerator >> majorObject: aFamixPWBmajorObject [
	majorObject := aFamixPWBmajorObject
]

{ #category : #tests }
PWBSmokeTestGenerator >> onCreateOn: stream [
	stream
		<< 'on';
		space;
		<< 'test_';
		<< majorObject name;
		<< '_case_generated';
		<< '.create';
		crlf;
		<< 'call super::create';
		crlf;
		<< 'end on'
]

{ #category : #printing }
PWBSmokeTestGenerator >> onDestroyOn: stream [
	stream
		<< 'on';
		space;
		<< 'test_';
		<< majorObject name;
		<< '_case_generated';
		<< '.destroy';
		crlf;
		<< 'call super::destroy';
		crlf;
		<< 'end on'
]

{ #category : #printing }
PWBSmokeTestGenerator >> printPWBScript: aFolder [
	^ (aFolder asFileReference
		/ ('test_' , majorObject name , '_case_generated' , '.sru'))
		ensureCreateFile;
		writeStreamDo:
				[ :stream | self testClassContentOn: stream ]
]

{ #category : #printing }
PWBSmokeTestGenerator >> testClassContentOn: stream [
	self testFileHeaderOn: stream.
	self forwardOn: stream.
	self fileDeclaredTypeOn: stream.
	stream crlf.
	majorObject behaviorToTest
		do: [ :behavior | 
			PWBSmokeTestEventGenerator new
				behavior: behavior;
				printPWBScriptOn: stream.
			stream
				crlf;
				crlf ].
	self onCreateOn: stream.
	stream crlf.
	^ self onDestroyOn: stream
]

{ #category : #tests }
PWBSmokeTestGenerator >> testFileHeaderOn: stream [
	stream
		nextPut: $$;
		<< 'PBExportHeader';
		<< $$;
		<< 'test_';
		<< majorObject name;
		<< '_case_generated';
		<< '.sru';
		crlf
]
