Class {
	#name : #PWBTestDatawindowInstanceVariableCreator,
	#superclass : #PWBTestInstanceVariableCreator,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #visiting }
PWBTestDatawindowInstanceVariableCreator class >> accept: anAccess [
	^ anAccess variable isPWBDataWindow
]

{ #category : #'as yet unclassified' }
PWBTestDatawindowInstanceVariableCreator >> access: acc on: stream [
	stream
		<< acc pwbTestVariableName;
		<< '.reset()';
		crlf;
		<< acc pwbTestVariableName;
		<< '.dataobject = "';
		<< acc beforeValueDataobject;
		nextPut: $";
		crlf.
	self
		addRows: acc pwbTestVariableName
		tag: 'before'
		on: stream
		dwParam: acc.
	^ stream
]

{ #category : #adding }
PWBTestDatawindowInstanceVariableCreator >> addRows: dwName tag: aTag on: aStream dwParam: aDwParam [
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
