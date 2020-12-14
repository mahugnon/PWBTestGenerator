Class {
	#name : #DataStoreSolver,
	#superclass : #PWBTypeValueSolver,
	#category : #'PWBTestGenerator-TypeResolver'
}

{ #category : #'as yet unclassified' }
DataStoreSolver class >> accept: aMrlParameter [
	| paramName |
	paramName := aMrlParameter parameterType name.
	^ paramName asLowercase = 'datastore'
		or: [ paramName beginsWith: 'ds_' ]
]

{ #category : #printing }
DataStoreSolver class >> acceptType: aTypeName [
	^ aTypeName asLowercase = 'datastore'
		or: [ aTypeName beginsWith: 'ds_' ]
]

{ #category : #resolving }
DataStoreSolver >> addRowsWithTagOn: stream [
	| colones paramValue |
	paramValue := tag = 'before'
		ifTrue: [ focus parameter_before_value ]
		ifFalse: [ focus parameter_after_value ].
	colones := (CSVParser parseWithHeader: paramValue) anyOne.
	colones
		keysAndValuesDo: [ :key :value | 
			value
				ifNotNil: [ stream
						<< varName;
						<< '.setItem(';
						<< varName;
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
						<< varName;
						<< '.object.';
						<< key asString;
						<< '.colType';
						nextPut: $);
						nextPut: $);
						crlf ] ]
]

{ #category : #resolving }
DataStoreSolver >> createDataStoreOn: stream [
	varName := 'l'
		, (focus parameter_name copyFrom: 2 to: focus parameter_name size)
		, '_' , tag.
	^ stream
		<< varName;
		space;
		<< '=';
		space;
		<< 'create datastore';
		crlf
]

{ #category : #resolving }
DataStoreSolver >> dataObjectOn: stream [
	^ stream
		<< varName;
		<< '.dataobject =';
		<< '"';
		<< focus parameter_dataobject;
		<< '"';
		crlf
]

{ #category : #resolving }
DataStoreSolver >> printParameter: aMrlParameter on: stream [
	focus := aMrlParameter.
	self resolveOn: stream withTag: 'before'.
	focus parameter_after_value
		ifNotNil: [ self resolveOn: stream withTag: 'after' ]
]

{ #category : #printing }
DataStoreSolver >> printValue: aString [
	
]

{ #category : #resolving }
DataStoreSolver >> resolveOn: stream withTag: aTag [
	tag := aTag.
	self createDataStoreOn: stream.
	self dataObjectOn: stream.
	self transObjectOn: stream.
	self rowOn: stream.
	self addRowsWithTagOn: stream
]

{ #category : #resolving }
DataStoreSolver >> rightSideOn: stream [
	"do nothing"
]

{ #category : #resolving }
DataStoreSolver >> rowOn: stream [
	^ stream
		<< varName;
		<< '.insertRow(0)';
		crlf
]

{ #category : #resolving }
DataStoreSolver >> transObjectOn: stream [
	^ stream
		<< varName;
		<< '.setTrans(SQLCA)';
		crlf
]
