Class {
	#name : #MrlDescriptorAbstractSystem,
	#superclass : #DescriptorSystem,
	#category : #'PWBTestsDataGenerator-Model'
}

{ #category : #'accessing structure variables' }
MrlDescriptorAbstractSystem class >> driver [
	<script>
	PharoDatabaseAccessor DefaultDriver: P3DatabaseDriver
]

{ #category : #private }
MrlDescriptorAbstractSystem >> cleanTableName: aString [
^ (aString  copyReplaceAll: 'PUBLIC.' with:'' ) copyReplaceAll: '"' with: ''
]

{ #category : #private }
MrlDescriptorAbstractSystem >> initializeTable: newTable [
	| initializerName |
	initializerName := ('tableFor' , ( self cleanTableName: newTable name   asUppercase) , ':') asSymbol.
	(self respondsTo: initializerName)
		ifTrue: [self perform: initializerName with: newTable]
		ifFalse: [self noTableInitializerFound: newTable].
	newTable postInitializeIn: self.
	self deferentialSetSchema: newTable.
]
