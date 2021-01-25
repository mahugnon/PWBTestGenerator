Class {
	#name : #PWBTestDatawindowParamCreator,
	#superclass : #PWBTestParameterCreator,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #visiting }
PWBTestDatawindowParamCreator class >> accept: aMrlParam [
	^ aMrlParam isPWBDataWindow
]

{ #category : #adding }
PWBTestDatawindowParamCreator >> addRows: dwName tag: aTag on: aStream dwParam: aDwParam [
	| pwbData paramValue |
	paramValue := aTag = 'before'
		ifTrue: [ aDwParam beforeValue mrlvalue ]
		ifFalse: [ aDwParam afterValue mrlvalue ].
	pwbData := CSVParser parseWithHeader: paramValue.
	pwbData ifEmpty: [ ^ aStream ].
	aStream
		<< dwName;
		<< '.insertRow(0)';
		crlf.
	pwbData anyOne
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

{ #category : #'as yet unclassified' }
PWBTestDatawindowParamCreator >> param: param on: stream [
	self setValues: stream tag: 'before' dwParam: param.
	param parameter_after_value
		ifNotNil: [ self setValues: stream tag: 'after' dwParam: param ]
]

{ #category : #initialization }
PWBTestDatawindowParamCreator >> setValues: stream tag: aTag dwParam: aDWParam [
	| dwName |
	dwName := 'lw_PBUnitTest_window.dw_' , aTag.
	stream
		<< dwName;
		<< '.dataobject = ';
		<< '"';
		<< (aDWParam parameter_dataobjectForTag: aTag);
		<< '"';
		crlf;
		<< dwName;
		<< '.setTrans(SQLCA)';
		crlf.
	self
		addRows: dwName
		tag: aTag
		on: stream
		dwParam: aDWParam
]
