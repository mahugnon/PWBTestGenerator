Class {
	#name : #PWBSmokeTestEventGenerator,
	#superclass : #Object,
	#instVars : [
		'behavior'
	],
	#category : #'PWBTestGenerator-SmokeTests'
}

{ #category : #visiting }
PWBSmokeTestEventGenerator class >> accept: aFamixPWBInvocation [
	^ self subclassResponsibility
]

{ #category : #visiting }
PWBSmokeTestEventGenerator class >> acceptFunction: aFamixPWBFunction [
	^ self subclassResponsibility
]

{ #category : #printing }
PWBSmokeTestEventGenerator >> beginTryOn: stream [
	stream
		<< 'TRY';
		crlf
]

{ #category : #accessing }
PWBSmokeTestEventGenerator >> behavior: aFamixPWBEvent [ 
	behavior := aFamixPWBEvent
]

{ #category : #printing }
PWBSmokeTestEventGenerator >> behaviorInvocationOn: stream [
	PWBSmokeTestBehaviorCreator behaviorInvocation: behavior on: stream
]

{ #category : #printing }
PWBSmokeTestEventGenerator >> endTryOn: stream [
	stream
		<< 'CATCH (runtimeerror er)';
		crlf;
		<< 'this.assert(Er.getmessage(),false)';
		crlf;
		<< 'FINALLY';
		crlf.
	behavior parentType closeOn: stream.
	stream
		<< 'END TRY';
		crlf
]

{ #category : #printing }
PWBSmokeTestEventGenerator >> footerEventOn: stream [
	stream  << 'end event'
]

{ #category : #'as yet unclassified' }
PWBSmokeTestEventGenerator >> genericCommentOn: stream [
	stream
		<< '/*';
		crlf;
		<<
			'Ce test est un test généré dans le cadre du projet de la CIM recherche en colaboration avec l''INRIA.';
		crlf;
		<<
			'Trouver le projet de generation sur github:https://github.com/mahugnon/PWBTestGenerator.git';
		crlf;
		<< 'La method tester ici est:';
		space;
		<< behavior name;
		space;
		<< 'de ';
		<< behavior parentType name;
		crlf;
		<< 'Autheur: HOUEKPETODJI Mahugnon Honoré';
		crlf;
		<< '*/';
		crlf;
		crlf
]

{ #category : #printing }
PWBSmokeTestEventGenerator >> headerEventOn: stream [
	^ stream
		<< 'event';
		space;
		<< 'test_';
		<< behavior name;
		<< '_smoke_generated';
		<< '();';
		crlf;
		crlf
]

{ #category : #accessors }
PWBSmokeTestEventGenerator >> mrlBehavior: aMrlBehavior [ 
	behavior := aMrlBehavior
]

{ #category : #printing }
PWBSmokeTestEventGenerator >> ownerObjectOn: stream [
	PWBTestObjectCreator objectNamed: behavior parentType name on: stream
]

{ #category : #printing }
PWBSmokeTestEventGenerator >> printPWBScriptOn: stream [
	self headerEventOn: stream.
	self genericCommentOn: stream.
	self beginTryOn: stream.
	self ownerObjectOn: stream.
	self behaviorInvocationOn: stream.
	self smokeAssertOn: stream.
	self endTryOn: stream.
	self footerEventOn: stream.
	^ stream
]

{ #category : #asserting }
PWBSmokeTestEventGenerator >> smokeAssertOn: stream [
	stream
		<< 'this.assert(true)';
		crlf
]
