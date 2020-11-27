Class {
	#name : #PWBAbstractModel,
	#superclass : #Object,
	#classInstVars : [
		'login'
	],
	#category : #'PWBTestGenerator-DataModel-Model'
}

{ #category : #'as yet unclassified' }
PWBAbstractModel class >> loadAll [
	| result session |
	session := self session.
	result := session read: self.
	session logout.
	^ result
]

{ #category : #'as yet unclassified' }
PWBAbstractModel class >> loadWhere: aBlock [
	| result session |
	session := self session.
	result := session read: self where: aBlock.
	session logout.
	^ result
]

{ #category : #'as yet unclassified' }
PWBAbstractModel class >> loadWhere: aBlock limit: anInteger [
	| result session |
	session := self session.
	result := session read: self where: aBlock limit: anInteger.
	session logout.
	^ result
]

{ #category : #accessing }
PWBAbstractModel class >> login [
	login
		ifNil: [ login := Login new
				setSSL;
				database: PostgreSQLPlatform new;
				username: 'tosca';
				password: 'nkgqK8DHxzbT';
				host: 'cldb01tsc999p.sa-cim.local';
				port: '5432';
				databaseName: 'tosca'.
			login secure: false.
			(DatabaseAccessor forLogin: login) login ].
	^ login
]

{ #category : #initialization }
PWBAbstractModel class >> resetLogin [
	<script>
	login := nil
]

{ #category : #'as yet unclassified' }
PWBAbstractModel class >> session [
	| session |
	self setDriver.
	session := (MrlDescriptorAbstractSystem getDescriptor: self name)
		sessionForLogin: self login.
	session login.
	^ session
]

{ #category : #initialization }
PWBAbstractModel class >> setDriver [
	Smalltalk
		at: #NativePostgresDriver
		ifAbsent: [ PharoDatabaseAccessor DefaultDriver: P3DatabaseDriver ]
]
