Class {
	#name : #PWBDatawindowInstanceGenrator,
	#superclass : #Object,
	#instVars : [
		'name',
		'originalSyntax',
		'cleanSyntax',
		'script',
		'selectSql'
	],
	#category : #PWBTestsGenerator
}

{ #category : #accessing }
PWBDatawindowInstanceGenrator >> cleanSyntax [
	^ cleanSyntax
]

{ #category : #'as yet unclassified' }
PWBDatawindowInstanceGenrator >> generationCreationCreationScript [
	script := String
		streamContents: [ :stream | 
			self printCreateDatawindowScriptOn: stream.
			self tranObjectString: stream.
			self printSelectSqlOn: stream ].
	(PWBDataWindowParser new dataWindowFile parse: cleanSyntax)
		fileStatements
		select: [ :each | each isKindOf: PWBASTGraphicComponent ]
		thenDo: [ :comp | comp printModifyOn: self ].
	^ script
]

{ #category : #initialization }
PWBDatawindowInstanceGenrator >> initialize [ 
super initialize .
script := ''.
]

{ #category : #api }
PWBDatawindowInstanceGenrator >> initializeDatawindowScript [
	^ String
		streamContents: [ :stream | 
			stream
				<< 'datawindow';
				space;
				<< name;
				crlf;
				<< name;
				space;
				<< '=';
				space;
				<< 'create datawindow';
				crlf ]
]

{ #category : #accessing }
PWBDatawindowInstanceGenrator >> name [
	^ name
]

{ #category : #accessing }
PWBDatawindowInstanceGenrator >> name: aString [ 
	name := aString
]

{ #category : #accessing }
PWBDatawindowInstanceGenrator >> originalSyntax [
	^ originalSyntax
]

{ #category : #accessing }
PWBDatawindowInstanceGenrator >> originalSyntax: aString [
	originalSyntax := aString.
	self syntaxCleaning
]

{ #category : #api }
PWBDatawindowInstanceGenrator >> printCreateDatawindowScriptOn: stream [
	^ stream
		<< 'datawindow';
		space;
		<< name;
		crlf;
		<< name;
		space;
		<< '=';
		space;
		<< 'create datawindow';
		crlf
]

{ #category : #'as yet unclassified' }
PWBDatawindowInstanceGenrator >> printSelectSqlOn: aStream [
	aStream
		<< name;
		<< '.SetSQLSelect(';
		nextPut: $";
		<<( selectSql copyReplaceAll: String crlf  with:' ') ;
		nextPut: $";
		<< ')';
		
		crlf
]

{ #category : #accessing }
PWBDatawindowInstanceGenrator >> script [
	^ script
]

{ #category : #accessing }
PWBDatawindowInstanceGenrator >> script: aString [ 
	script := aString
]

{ #category : #accessing }
PWBDatawindowInstanceGenrator >> selectSql [
	^ selectSql
]

{ #category : #accessing }
PWBDatawindowInstanceGenrator >> selectSql: anObject [
	selectSql := anObject
]

{ #category : #api }
PWBDatawindowInstanceGenrator >> syntaxCleaning [
	cleanSyntax := originalSyntax
		replaceAllRegex: 'release.*datawindow\(.*no \)'
		with:
			'datawindow(units=0 timer_interval=0 color=1073741824 processing=0 HTMLDW=no print.documentname="" print.orientation = 0 print.margin.left = 110 print.margin.right = 110 print.margin.top = 96 print.margin.bottom = 96 print.paper.source = 0 print.paper.size = 0 print.prompt=no print.buttons=no print.preview.buttons=no )

header(height=72 color="536870912" )

summary(height=8 color="536870912" )

footer(height=0 color="536870912" )

detail(height=72 color="536870912" )'
]

{ #category : #'as yet unclassified' }
PWBDatawindowInstanceGenrator >> tranObjectString: aStream [
	aStream
		<< name;
		<< '.SetTransObject(SqlCa)';
		crlf
]
