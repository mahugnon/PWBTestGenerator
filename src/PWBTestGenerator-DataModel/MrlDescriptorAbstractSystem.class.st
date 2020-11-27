Class {
	#name : #MrlDescriptorAbstractSystem,
	#superclass : #DescriptorSystem,
	#category : #'PWBTestGenerator-DataModel-SystemDescriptors'
}

{ #category : #'accessing structure variables' }
MrlDescriptorAbstractSystem class >> driver [
	<script>
	PharoDatabaseAccessor DefaultDriver: P3DatabaseDriver
]

{ #category : #'as yet unclassified' }
MrlDescriptorAbstractSystem class >> getDescriptor: aClassName [
	^ self subclasses detect: [ :sub | sub name beginsWith: aClassName ]
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
