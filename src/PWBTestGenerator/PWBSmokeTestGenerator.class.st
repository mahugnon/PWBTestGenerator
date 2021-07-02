Class {
	#name : #PWBSmokeTestGenerator,
	#superclass : #Object,
	#instVars : [
		'majorObject'
	],
	#category : #'PWBTestGenerator-Core'
}

{ #category : #'as yet unclassified' }
PWBSmokeTestGenerator class >> generateForModel1: aFamixPWBModel in: aFolder [
	(aFamixPWBModel allWithType: FamixPWBmajorObject)
		do: [ :aBehavior | 
			aBehavior isPrivate
				ifTrue: [ ^ self ].
			self new
				behavior: aBehavior;
				printPWBScript: aFolder ]
		displayingProgress: [ :aBehavior | aBehavior name ]
]

{ #category : #'as yet unclassified' }
PWBSmokeTestGenerator class >> generateForModel: aFamixPWBModel in: aFolder [
	((aFamixPWBModel allWithType: FamixPWBEvent)
		select: [ :each | 
			each name ~= 'constructor'
				and: [ each name ~= 'destructor' and: [ each parentType isNotNil ] ] ])
		do: [ :aBehavior | 
			aBehavior isPrivate
				ifTrue: [ ^ self ].
			self new
				behavior: aBehavior;
				printPWBScript: aFolder ]
		displayingProgress: [ :aBehavior | aBehavior name ]
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
		writeStreamDo: [ :stream | 
			self testFileHeaderOn: stream.
			self forwardOn: stream.
			self fileDeclaredTypeOn: stream.
			stream crlf.
			majorObject behaviorToTest
				do: [ :behavior | 
					PWBSmokeTestEventGenerator new
						behavior: behavior;
						printPWBScriptOn: stream.
					stream crlf ].
			self onCreateOn: stream.
			stream crlf.
			self onDestroyOn: stream ]
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
