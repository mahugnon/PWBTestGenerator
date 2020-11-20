Class {
	#name : #DatawindowValueResolver,
	#superclass : #PWBTypeValueResolver,
	#instVars : [
		'dw_fullName'
	],
	#category : #'PWBTestsGenerator-PWBTestUnitStrategy'
}

{ #category : #'as yet unclassified' }
DatawindowValueResolver class >> accept: aTypeName [
	^ aTypeName asLowercase beginsWith: 'dw_'
]

{ #category : #accessing }
DatawindowValueResolver >> dw_fullName [
	^ dw_fullName
]

{ #category : #accessing }
DatawindowValueResolver >> dw_fullName: anObject [
	dw_fullName := anObject
]

{ #category : #resolving }
DatawindowValueResolver >> resolve: aValue [
	^ String
		streamContents: [ :stream | 
			
			self setUpWith: aValue on: stream ]
]

{ #category : #initialization }
DatawindowValueResolver >> setUpDw: aStream [
	aStream
		<< dw_fullName;
		<< '.setTrans(SQLCA)';
		crlf;
		<< dw_fullName;
		<< '.insertRow(0)';
		crlf
]

{ #category : #initialization }
DatawindowValueResolver >> setUpWith: aString on: stream [
	| rows data |
	data := CSVParser parseWithHeader: aString.
	data ifEmpty: [ ^ stream ].
	self setUpDw: stream.
	rows := data anyOne.
	rows
		keysAndValuesDo: [ :key :value | 
			value
				ifNotNil: [ stream
						<< dw_fullName;
						<< '.setItem(';
						<< dw_fullName;
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
						<< dw_fullName;
						<< '.object.';
						<< key asString;
						<< '.colType';
						nextPut: $);
						nextPut: $);
						crlf ] ].
	^ stream
]
