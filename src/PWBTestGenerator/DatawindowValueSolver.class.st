Class {
	#name : #DatawindowValueSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #printing }
DatawindowValueSolver class >> acceptType: aTypeName [
	^ false
]

{ #category : #'as yet unclassified' }
DatawindowValueSolver class >> resolve: aMrlParameter [
	^ self new resolve: aMrlParameter
]

{ #category : #initialization }
DatawindowValueSolver >> addRows: dwName tag: aTag on: aStream [
	| colones paramValue |
	paramValue := aTag = 'before'
		ifTrue: [ focus parameter_before_value ]
		ifFalse: [ focus parameter_after_value ].
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
DatawindowValueSolver >> printParameter: aPWBParameter on: stream [
	focus := aPWBParameter.
	^ self scriptOn: stream
]

{ #category : #resolving }
DatawindowValueSolver >> resolve: aPWBParameter [
	focus := aPWBParameter.
	^ String streamContents: [ :stream | self scriptOn: stream ]
]

{ #category : #resolving }
DatawindowValueSolver >> scriptOn: aStream [
	self setValues: aStream tag: 'before'.
	focus parameter_after_value
		ifNotNil: [ self setValues: aStream tag: 'after' ]
]

{ #category : #initialization }
DatawindowValueSolver >> setValues: aStream tag: aTag [
	| dwName |
	dwName := 'lw_PBUnitTest_window.dw_' , aTag.
	aStream
		<< dwName;
		<< '.dataobject = ';
		<< '"';
		<< focus parameter_dataobject;
		<< '"';
		crlf;
		<< dwName;
		<< '.setTrans(SQLCA)';
		crlf;
		<< dwName;
		<< '.insertRow(0)';
		crlf.
	self addRows: dwName tag: aTag on: aStream
]
