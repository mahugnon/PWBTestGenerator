Class {
	#name : #PWBReturnBasedUnitAssertionDataWindowParam,
	#superclass : #PWBAbstractReturnBaseUnitAssertion,
	#category : #'PWBTestGenerator-Task'
}

{ #category : #'as yet unclassified' }
PWBReturnBasedUnitAssertionDataWindowParam class >> accept: aCollection [
	^ aCollection anySatisfy: #isPWBDataWindow
]

{ #category : #printing }
PWBReturnBasedUnitAssertionDataWindowParam >> printPWBScriptOn: stream [
	self printWindowDwSetUpOn: stream.
	super printPWBScriptOn: stream.
	^ stream
]

{ #category : #printing }
PWBReturnBasedUnitAssertionDataWindowParam >> printParametersInitializationOn: stream [
	self pwbParameters
		do: [ :param | 
			param isPWBDataWindow
				ifFalse: [ PWBVariableInitializer printParameter: param on: stream ] ].
	^ stream
]

{ #category : #printing }
PWBReturnBasedUnitAssertionDataWindowParam >> printWindowDwSetUpOn: stream [
	| dwParam |
	dwParam := self pwbParameters
		detect: [ :param | param isPWBDataWindow ].
	self setValues: stream tag: 'before' dwParam: dwParam.
	dwParam parameter_after_value
		ifNotNil: [ self setValues: stream tag: 'after' dwParam: dwParam ]
]

{ #category : #printing }
PWBReturnBasedUnitAssertionDataWindowParam >> setValues: stream tag: aTag dwParam: aDWParam [
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
