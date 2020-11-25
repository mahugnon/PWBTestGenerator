Class {
	#name : #PWBDWFieldTypeExtractor1,
	#superclass : #Object,
	#instVars : [
		'parameter'
	],
	#category : #'PWBTestGenerator-DataModel-Utilities'
}

{ #category : #accessing }
PWBDWFieldTypeExtractor1 class >> parameter: aMrlParameter [
	^ self new parameter: aMrlParameter
]

{ #category : #'as yet unclassified' }
PWBDWFieldTypeExtractor1 >> extractOn: aStream [
	self setUpDw: aStream.
	self setValues: aStream tag: 'before'.
	parameter parameter_after_value
		ifNotNil: [ self setValues: aStream tag: 'after' ]
]

{ #category : #accessing }
PWBDWFieldTypeExtractor1 >> parameter [
	^ parameter
]

{ #category : #accessing }
PWBDWFieldTypeExtractor1 >> parameter: anObject [
	parameter := anObject
]

{ #category : #initialization }
PWBDWFieldTypeExtractor1 >> setUpDw: aStream [
	aStream
		<< 'lw_maryline_test_window.dw_input.dataobject = ';
		<< '"';
		<< parameter parameter_dataobject;
		<< '"';
		crlf;
		<< 'lw_maryline_test_window.dw_input.setTrans(SQLCA)';
		crlf;
		<< 'lw_maryline_test_window.dw_output.dataobject = ';
		<< '"';
		<< parameter parameter_dataobject;
		<< '"';
		crlf;
		<< 'lw_maryline_test_window.dw_output.setTrans(SQLCA)';
		crlf
]

{ #category : #initialization }
PWBDWFieldTypeExtractor1 >> setValues: aStream tag: aTag [
	aStream
		<< 'lw_maryline_test_window.dw_';
		<< aTag;
		<< '.ImportString(';
		<< parameter parameter_before_value;
		<< ')';
		crlf
]
