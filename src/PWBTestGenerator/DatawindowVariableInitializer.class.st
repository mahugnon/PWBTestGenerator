Class {
	#name : #DatawindowVariableInitializer,
	#superclass : #PWBVariableInitializer,
	#category : #'PWBTestGenerator-VariableInitializers'
}

{ #category : #printing }
DatawindowVariableInitializer class >> acceptType: aTypeName [
	^ false
]

{ #category : #'as yet unclassified' }
DatawindowVariableInitializer class >> resolve: aMrlParameter [
	^ self new resolve: aMrlParameter
]

{ #category : #initialization }
DatawindowVariableInitializer >> addRows: dwName tag: aTag on: aStream [
	| colones paramValue |
	paramValue := aTag = 'before'
		ifTrue: [ focus parameter_before_value mrlValue ]
		ifFalse: [ focus parameter_after_value mrlValue ].
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
DatawindowVariableInitializer >> printParameter: aPWBParameter on: stream [
	focus := aPWBParameter.
	^ self scriptOn: stream
]

{ #category : #resolving }
DatawindowVariableInitializer >> resolve: aPWBParameter [
	focus := aPWBParameter.
	^ String streamContents: [ :stream | self scriptOn: stream ]
]

{ #category : #resolving }
DatawindowVariableInitializer >> scriptOn: aStream [
	self setValues: aStream tag: 'before'.
	focus parameter_after_value
		ifNotNil: [ self setValues: aStream tag: 'after' ]
]

{ #category : #initialization }
DatawindowVariableInitializer >> setValues: aStream tag: aTag [
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
