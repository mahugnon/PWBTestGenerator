Class {
	#name : #MrlAbstractModel,
	#superclass : #Object,
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #'as yet unclassified' }
MrlAbstractModel class >> loadAll [
	^ self session read: self
]

{ #category : #'as yet unclassified' }
MrlAbstractModel class >> loadWhere: aBlock [
	^ self session read: self where: aBlock
]

{ #category : #accessing }
MrlAbstractModel class >> login [
	| login |
	login := Login new
		setSSL;
		database: PostgreSQLPlatform new;
		username: 'lpavlalufjmnyh';
		password: 'b7b6af9d4457652c5595770cc5e8dac18fa78386e4f4ca995067ad4ea5c3baff';
		host: 'ec2-18-233-32-61.compute-1.amazonaws.com';
		port: '5432';
		databaseName: 'd6dfd82tvqmqe0'.
	login secure: false.
	(DatabaseAccessor forLogin: login) login.
	^ login
]

{ #category : #'as yet unclassified' }
MrlAbstractModel class >> session [
	^ self subclassResponsibility
]
