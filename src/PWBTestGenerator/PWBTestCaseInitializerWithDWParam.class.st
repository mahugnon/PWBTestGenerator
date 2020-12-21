Class {
	#name : #PWBTestCaseInitializerWithDWParam,
	#superclass : #PWBTestCaseInitializer,
	#category : #'PWBTestGenerator-Task'
}

{ #category : #visiting }
PWBTestCaseInitializerWithDWParam class >> accept: aCollection [
	^ aCollection anySatisfy: #isPWBDataWindow
]

{ #category : #printing }
PWBTestCaseInitializerWithDWParam >> printPWBScriptOn: stream [
	self printWindowDwSetUpOn: stream.
	super printPWBScriptOn: stream.
	^ stream
]

{ #category : #printing }
PWBTestCaseInitializerWithDWParam >> printWindowDwSetUpOn: stream [
	| dwParam |
	dwParam := self pwbParameters
		detect: [ :param | param isPWBDataWindow ].
	self setValues: stream tag: 'before' dwParam: dwParam.
	dwParam parameter_after_value
		ifNotNil: [ self setValues: stream tag: 'after' dwParam: dwParam ]
]

{ #category : #initialization }
PWBTestCaseInitializerWithDWParam >> setValues: stream tag: aTag dwParam: aDWParam [
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
