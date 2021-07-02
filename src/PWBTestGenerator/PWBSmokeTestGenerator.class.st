Class {
	#name : #PWBSmokeTestGenerator,
	#superclass : #Object,
	#instVars : [
		'behavior'
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

{ #category : #accessing }
PWBSmokeTestGenerator >> behavior: aFamixPWBEvent [ 
	behavior := aFamixPWBEvent
]

{ #category : #tests }
PWBSmokeTestGenerator >> fileDeclaredTypeOn: stream [
	stream
		<< 'global type';
		space;
		<< 'test_';
		<< behavior name;
		<< '_case_generated';
		space;
		<< 'from';
		space;
		<< 'testcase';
		crlf;
		<< 'event';
		space;
		<< 'test_';
		<< behavior name;
		space;
		<< '()';
		crlf;
		<< 'end type';
		crlf;
		<< 'global';
		space;
		<< 'test_';
		<< behavior name;
		<< '_case_generated';
		space;
		<< 'test_';
		<< behavior name;
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
		<< behavior name;
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
		<< behavior name;
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
		<< behavior name;
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
		/ ('test_' , behavior name , '_case_generated' , '.sru'))
		ensureCreateFile;
		writeStreamDo: [ :stream | 
			self testFileHeaderOn: stream.
			self forwardOn: stream.
			self fileDeclaredTypeOn: stream.
			stream crlf.
			PWBSmokeTestEventGenerator new
				behavior: behavior;
				printPWBScriptOn: stream.
			stream crlf.
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
		<< behavior name;
		<< '_case_generated';
		<< '.sru';
		crlf
]
