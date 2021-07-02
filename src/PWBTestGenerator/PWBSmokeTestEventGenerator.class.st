Class {
	#name : #PWBSmokeTestEventGenerator,
	#superclass : #Object,
	#instVars : [
		'behavior'
	],
	#category : #'PWBTestGenerator-Core'
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
	PWBTestBehaviorCreator behaviorInvocation: behavior on: stream
]

{ #category : #printing }
PWBSmokeTestEventGenerator >> endTryOn: stream [
	stream
		<< 'CATCH (runtimeerror er)';
		crlf;
		<< 'this.assert(Er.getmessage(),false)';
		crlf;
		<< 'FINALLY';
		crlf;
		<< 'Destroy';
		space;
		<< 'l';
		<< behavior parentType name;
		crlf;
		<< 'END TRY';
		crlf
]

{ #category : #printing }
PWBSmokeTestEventGenerator >> footerEventOn: stream [
	stream  << 'end event'
]

{ #category : #printing }
PWBSmokeTestEventGenerator >> headerEventOn: stream [
	^ stream
		<< 'event';
		space;
		<< 'test_';
		<< behavior name;
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
