Class {
	#name : #MarylineDWFieldTypeExtractor,
	#superclass : #Object,
	#instVars : [
		'parameter'
	],
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #accessing }
MarylineDWFieldTypeExtractor class >> parameter: aMrlParameter [
	^ self new parameter: aMrlParameter
]

{ #category : #'as yet unclassified' }
MarylineDWFieldTypeExtractor >> extractOn: aStream [
	self setUpDw: aStream.
	self setBeforeValues: aStream.
	parameter parameter_after_value
		ifNotNil: [ self setAfterValues: aStream ]
]

{ #category : #accessing }
MarylineDWFieldTypeExtractor >> parameter [
	^ parameter
]

{ #category : #accessing }
MarylineDWFieldTypeExtractor >> parameter: anObject [
	parameter := anObject
]

{ #category : #initialization }
MarylineDWFieldTypeExtractor >> setAfterValues: aStream [
	| colones |
	colones := (CSVParser
		parseWithHeader: parameter parameter_after_value) anyOne.
	colones
		keysAndValuesDo: [ :key :value | 
			value
				ifNotNil: [ aStream
						<<
							'lw_maryline_test_window.dw_output.setItem(lw_maryline_test_window.dw_output.rowcount(),';
						<< '"';
						<< key asString;
						<< '",';
						<< 'f_mrl_parse(';
						space;
						nextPut: $";
						<< value;
						nextPut: $";
						nextPut: $,;
						<< 'lw_maryline_test_window.dw_output.object.';
						<< key asString;
						<< '.colType';
						nextPut: $);
						nextPut: $);
						crlf ] ]
]

{ #category : #initialization }
MarylineDWFieldTypeExtractor >> setBeforeValues: aStream [
	| colones |
	colones := (CSVParser
		parseWithHeader: parameter parameter_before_value) anyOne.
	colones
		keysAndValuesDo: [ :key :value | 
			value
				ifNotNil: [ aStream
						<<
							'lw_maryline_test_window.dw_input.setItem(lw_maryline_test_window.dw_input.rowcount(),';
						<< '"';
						<< key asString;
						<< '",';
						<< 'f_mrl_parse(';
						space;
						nextPut: $";
						<< value;
						nextPut: $";
						nextPut: $,;
						<< 'lw_maryline_test_window.dw_input.object.';
						<< key asString;
						<< '.colType';
						nextPut: $);
						nextPut: $);
						crlf ] ]
]

{ #category : #initialization }
MarylineDWFieldTypeExtractor >> setUpDw: aStream [
	aStream
		<< 'lw_maryline_test_window.dw_input.dataobject = ';
		<< '"';
		<< parameter parameter_dataobject;
		<< '"';
		crlf;
		<< 'lw_maryline_test_window.dw_input.setTrans(SQLCA)';
		crlf;
		<< 'lw_maryline_test_window.dw_input.insertRow(0)';
		crlf;
		<< 'lw_maryline_test_window.dw_output.dataobject = ';
		<< '"';
		<< parameter parameter_dataobject;
		<< '"';
		crlf;
		<< 'lw_maryline_test_window.dw_output.setTrans(SQLCA)';
		crlf;
		<< 'lw_maryline_test_window.dw_output.insertRow(0)';
		crlf
]
