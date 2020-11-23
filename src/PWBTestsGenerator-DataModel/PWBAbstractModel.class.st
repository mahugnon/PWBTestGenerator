Class {
	#name : #PWBAbstractModel,
	#superclass : #Object,
	#classInstVars : [
		'login'
	],
	#category : #'PWBTestsGenerator-DataModel-Model'
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
				username: 'lpavlalufjmnyh';
				password: 'b7b6af9d4457652c5595770cc5e8dac18fa78386e4f4ca995067ad4ea5c3baff';
				host: 'ec2-18-233-32-61.compute-1.amazonaws.com';
				port: '5432';
				databaseName: 'd6dfd82tvqmqe0'.
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
	^ self subclassResponsibility
]
