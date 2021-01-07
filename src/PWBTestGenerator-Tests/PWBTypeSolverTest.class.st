Class {
	#name : #PWBTypeSolverTest,
	#superclass : #TestCase,
	#instVars : [
		'testFunction',
		'testModel',
		'stream'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #accessing }
PWBTypeSolverTest >> script [
	^ stream contents copyReplaceAll: String crlf with: String cr
]

{ #category : #running }
PWBTypeSolverTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."

	stream := WriteStream on: String new
]

{ #category : #tests }
PWBTypeSolverTest >> testAddDatastoreRowsWithTagBefore [
	| mrlParameter |
	mrlParameter := MrlParameter new
		parameter_before_value:
			(MrlParameter_before_value new
				parameter_value: 't1,t2' , String crlf , 'bfv1,bfv2' , String crlf).
	DataStoreVariableInitializer new
		tag: 'before';
		varName: 'ds_testParam';
		focus: mrlParameter;
		addRowsWithTagOn: stream.
	self assert: self script equals: 'ds_testParam.setItem(ds_testParam.rowcount(),"t1",f_mrl_parse( "bfv1",ds_testParam.object.t1.colType))
ds_testParam.setItem(ds_testParam.rowcount(),"t2",f_mrl_parse( "bfv2",ds_testParam.object.t2.colType))
'
]

{ #category : #tests }
PWBTypeSolverTest >> testAnyValueVariableInitializerPrintValue [
	stream << (AnyValueVariableInitializer new printValue: 'aloba').
	self
		assert: self script
		equals:
			'aloba'
]

{ #category : #tests }
PWBTypeSolverTest >> testAnyValueVariableInitializerRightSideOn [
	| mrlParameter |
	mrlParameter := MrlParameter new
		parameter_before_value: (MrlParameter_before_value new parameter_value: 'aloba').
	AnyValueVariableInitializer new
		focus: mrlParameter;
		rightSideOn: stream.
	self assert: self script equals: '"aloba"
'
]

{ #category : #tests }
PWBTypeSolverTest >> testBooleanVariableInitializerRightSideOn [
	| mrlParameter |
	mrlParameter := MrlParameter new
		parameter_before_value: (MrlParameter_before_value new parameter_value: 'true').
	BooleanVariableInitializer new
		focus: mrlParameter;
		rightSideOn: stream.
	self
		assert: self script
		equals:
			'true
'
]

{ #category : #tests }
PWBTypeSolverTest >> testDataStoreVariableInitializerRightSideOn [
	| mrlParameter |
	mrlParameter := MrlParameter new
		parameter_before_value: (MrlParameter_before_value new parameter_value: 'true').
	DataStoreVariableInitializer new
		focus: mrlParameter;
		rightSideOn: stream.
	self assert: self script isEmpty
]

{ #category : #tests }
PWBTypeSolverTest >> testDatastoreInitializerCreateDataStoreOn [
	| mrlParameter |
	mrlParameter := MrlParameter new parameter_name: 'ds_testParam'.
	DataStoreVariableInitializer new
		tag: 'before';
		focus: mrlParameter;
		createDataStoreOn: stream.
	self assert: self script equals: 'ls_testParam_before = create datastore
'
]

{ #category : #tests }
PWBTypeSolverTest >> testDatastoreVariableInitializePrintParameterOn [
	| mrlParameter |
	mrlParameter := MrlParameter new
		parameter_name: 'ds_testParam';
		parameter_before_value:
			(MrlParameter_before_value new
				parameter_dataobject: 'dw_testParam';
				parameter_value: 't1,t2' , String crlf , 'bfv1,bfv2' , String crlf).
	DataStoreVariableInitializer new
		tag: 'before';
		focus: mrlParameter;
		printParameter: mrlParameter on: stream.
	self
		assert: self script
		equals:
			'ls_testParam_before = create datastore
ls_testParam_before.dataobject ="dw_testParam"
ls_testParam_before.setTrans(SQLCA)
ls_testParam_before.insertRow(0)
ls_testParam_before.setItem(ls_testParam_before.rowcount(),"t1",f_mrl_parse( "bfv1",ls_testParam_before.object.t1.colType))
ls_testParam_before.setItem(ls_testParam_before.rowcount(),"t2",f_mrl_parse( "bfv2",ls_testParam_before.object.t2.colType))
'
]

{ #category : #tests }
PWBTypeSolverTest >> testDatastoreVariableInitializerDataObjectOn [
	| mrlParameter |
	mrlParameter := MrlParameter new
		parameter_name: 'ds_testParam';
		parameter_before_value: (MrlParameter_before_value new parameter_dataobject: 'dw_testParam').
	DataStoreVariableInitializer new
		tag: 'before';
		varName: 'ds_testParam';
		focus: mrlParameter;
		dataObjectOn: stream.
	self
		assert: self script
		equals:
		'ds_testParam.dataobject ="dw_testParam"
'
]

{ #category : #tests }
PWBTypeSolverTest >> testDatastoreVariableInitializeresolvewithTag [
	| mrlParameter |
	mrlParameter := MrlParameter new
		parameter_name: 'ds_testParam';
		parameter_before_value:
			(MrlParameter_before_value new
				parameter_dataobject: 'dw_testParam';
				parameter_value: 't1,t2' , String crlf , 'bfv1,bfv2' , String crlf).
	DataStoreVariableInitializer new
		focus: mrlParameter;
		resolveOn: stream withTag: 'before'.
	self
		assert: self script
		equals:
			'ls_testParam_before = create datastore
ls_testParam_before.dataobject ="dw_testParam"
ls_testParam_before.setTrans(SQLCA)
ls_testParam_before.insertRow(0)
ls_testParam_before.setItem(ls_testParam_before.rowcount(),"t1",f_mrl_parse( "bfv1",ls_testParam_before.object.t1.colType))
ls_testParam_before.setItem(ls_testParam_before.rowcount(),"t2",f_mrl_parse( "bfv2",ls_testParam_before.object.t2.colType))
'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueBooleanSolver [
	self
		assert: (PWBVariableInitializer printValue: 'true' ofType: 'boolean')
		equals: 'true'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueDateSolver [
	self
		assert: (PWBVariableInitializer printValue: '06/01/2020' ofType: 'date')
		equals: 'date("06/01/2020")'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueNumberSolver [
	self
		assert: (PWBVariableInitializer printValue: '2.5' ofType: 'double')
		equals: '2.5'
]

{ #category : #tests }
PWBTypeSolverTest >> testTypeValueStringSolver [
	self
		assert: (PWBVariableInitializer printValue: 'hello' ofType: 'string')
		equals: '"hello"'
]
