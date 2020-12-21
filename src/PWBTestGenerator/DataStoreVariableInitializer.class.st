Class {
	#name : #DataStoreVariableInitializer,
	#superclass : #PWBVariableInitializer,
	#category : #'PWBTestGenerator-VariableInitializers'
}

{ #category : #'as yet unclassified' }
DataStoreVariableInitializer class >> accept: aMrlParameter [
	| paramName |
	paramName := aMrlParameter parameterType name.
	^ paramName asLowercase = 'datastore'
		or: [ paramName beginsWith: 'ds_' ]
]

{ #category : #printing }
DataStoreVariableInitializer class >> acceptType: aTypeName [
	^ aTypeName asLowercase = 'datastore'
		or: [ aTypeName beginsWith: 'ds_' ]
]

{ #category : #resolving }
DataStoreVariableInitializer >> addRowsWithTagOn: stream [
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
DataStoreVariableInitializer >> createDataStoreOn: stream [
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
DataStoreVariableInitializer >> dataObjectOn: stream [
	^ stream
		<< varName;
		<< '.dataobject =';
		<< '"';
		<< focus parameter_dataobject;
		<< '"';
		crlf
]

{ #category : #resolving }
DataStoreVariableInitializer >> printParameter: aMrlParameter on: stream [
	focus := aMrlParameter.
	self resolveOn: stream withTag: 'before'.
	focus parameter_after_value
		ifNotNil: [ self resolveOn: stream withTag: 'after' ]
]

{ #category : #printing }
DataStoreVariableInitializer >> printValue: aString [
	
]

{ #category : #resolving }
DataStoreVariableInitializer >> resolveOn: stream withTag: aTag [
	tag := aTag.
	self createDataStoreOn: stream.
	self dataObjectOn: stream.
	self transObjectOn: stream.
	self rowOn: stream.
	self addRowsWithTagOn: stream
]

{ #category : #resolving }
DataStoreVariableInitializer >> rightSideOn: stream [
	"do nothing"
]

{ #category : #resolving }
DataStoreVariableInitializer >> rowOn: stream [
	^ stream
		<< varName;
		<< '.insertRow(0)';
		crlf
]

{ #category : #resolving }
DataStoreVariableInitializer >> transObjectOn: stream [
	^ stream
		<< varName;
		<< '.setTrans(SQLCA)';
		crlf
]
