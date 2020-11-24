Class {
	#name : #DatawindowValueResolver,
	#superclass : #Object,
	#instVars : [
		'parameter'
	],
	#category : #'PWBTestsGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
DatawindowValueResolver class >> resolve: aMrlParameter [
	^ self new resolve: aMrlParameter
]

{ #category : #resolving }
DatawindowValueResolver >> resolve: aPWBParameter [
	parameter := aPWBParameter.
	^ String streamContents: [ :stream | self scriptOn: stream ]
]

{ #category : #resolving }
DatawindowValueResolver >> scriptOn: aStream [
	self setValues: aStream tag: 'before'.
	parameter parameter_after_value
		ifNotNil: [ self setValues: aStream tag: 'after' ]
]

{ #category : #initialization }
DatawindowValueResolver >> setValues: aStream tag: aTag [
	| dwName |
	dwName := 'lw_PBUnitTest_window.dw_' , aTag.
	aStream
		<< dwName;
		<< '.dataobject = ';
		<< '"';
		<< parameter parameter_dataobject;
		<< '"';
		crlf;
		<< dwName;
		<< '.setTrans(SQLCA)';
		crlf;
		<< dwName;
		<< '.ImportString(';
		<< parameter parameter_before_value;
		<< ')';
		crlf
]
