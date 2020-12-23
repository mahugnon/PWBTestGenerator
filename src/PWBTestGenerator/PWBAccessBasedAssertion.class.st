Class {
	#name : #PWBAccessBasedAssertion,
	#superclass : #PWBTestGeneratorTask,
	#instVars : [
		'behaviorAccesses'
	],
	#category : #'PWBTestGenerator-Task'
}

{ #category : #'as yet unclassified' }
PWBAccessBasedAssertion class >> assertionFor: aCollection [
	^ self new behaviorAccesses: aCollection
]

{ #category : #'as yet unclassified' }
PWBAccessBasedAssertion class >> assertionFor: aCollection timestamp: aString [
	^ self new
		behaviorAccesses: aCollection;
		timestamp: aString;
		yourself
]

{ #category : #'as yet unclassified' }
PWBAccessBasedAssertion >> basicTypeAccess: aMrlInstanceVariableAccess assertionOn: stream [
	^ stream
		<< 'this.assert(';
		<< aMrlInstanceVariableAccess afterValue mrlvalue;
		nextPut: $=;
		<< aMrlInstanceVariableAccess pwbTestVariableName;
		nextPut: $);
		crlf
]

{ #category : #accessing }
PWBAccessBasedAssertion >> behaviorAccesses [
	^ behaviorAccesses
]

{ #category : #accessing }
PWBAccessBasedAssertion >> behaviorAccesses: anObject [
	behaviorAccesses := anObject
]

{ #category : #printing }
PWBAccessBasedAssertion >> dataControlAccess: acc assertionOn: stream [
	stream
		<< 'this.assert(';
		<< acc pwbTestVariableName;
		<< '.dataobject = "';
		<< acc afterValueDataobject;
		<< '")';
		crlf.
	stream
		<< 'this.assert(f_get_datacontrol_content(';
		<< acc pwbTestVariableName;
		<< ') = "';
		<< (self replaceLineBreakWithPwbLinebreak: acc afterValue mrlvalue);
		<< '")';
		crlf.
	^ stream
]

{ #category : #initialization }
PWBAccessBasedAssertion >> initialize [
	super initialize.
	behaviorAccesses := OrderedCollection new
]

{ #category : #testing }
PWBAccessBasedAssertion >> isAccessBasedAssertion [
	^ true
]

{ #category : #printing }
PWBAccessBasedAssertion >> printPWBScriptOn: stream [
	behaviorAccesses
		do: [ :acc | 
			acc beforeValueDataobject
				ifNil: [ self basicTypeAccess: acc assertionOn: stream ]
				ifNotNil: [ self dataControlAccess: acc assertionOn: stream ] ].
	^ stream
]

{ #category : #accessing }
PWBAccessBasedAssertion >> priority [
	^ 30
]

{ #category : #'as yet unclassified' }
PWBAccessBasedAssertion >> replaceLineBreakWithPwbLinebreak: aString [
	"Remove cr the avoid PWB errors"

	^ (aString copyReplaceAll: String cr with: '')
		copyReplaceAll: String lf
		with: ''
]
