Class {
	#name : #DatawindowValueResolver,
	#superclass : #Object,
	#instVars : [
		'parameter'
	],
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
DatawindowValueResolver class >> resolve: aMrlParameter [
	^ self new resolve: aMrlParameter
]

{ #category : #initialization }
DatawindowValueResolver >> addDwRows: dwName tag: aTag on: aStream [
	| colones paramValue |
	paramValue := aTag = 'before'
		ifTrue: [ parameter parameter_before_value ]
		ifFalse: [ parameter parameter_after_value ].
	colones := (CSVParser parseWithHeader: paramValue) anyOne.
	colones
		keysAndValuesDo: [ :key :value | 
			value
				ifNotNil: [ aStream
						<< dwName;
						<< '.setItem(';
						<< dwName;
						<< '.rowcount(),';
						<< '"';
						<< key asString;
						<< '",';
						<< 'f_mrl_parse(';
						space;
						nextPut: $";
						<< value;
						nextPut: $";
						nextPut: $,;
						<< dwName;
						<< '.object.';
						<< key asString;
						<< '.colType';
						nextPut: $);
						nextPut: $);
						crlf ] ]
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
		<< '.insertRow(0)';
		crlf.
	self addDwRows: dwName tag: aTag on: aStream
]
