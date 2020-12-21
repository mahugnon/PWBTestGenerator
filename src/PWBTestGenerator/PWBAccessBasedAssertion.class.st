Class {
	#name : #PWBAccessBasedAssertion,
	#superclass : #Object,
	#instVars : [
		'behaviorAccesses'
	],
	#category : #'PWBTestGenerator-Assertions'
}

{ #category : #'as yet unclassified' }
PWBAccessBasedAssertion class >> assertionFor: aCollection [
	^ self new behaviorAccesses: aCollection
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

{ #category : #printing }
PWBAccessBasedAssertion >> printAccessAssertionOn: stream [
	behaviorAccesses
		do: [ :acc | 
			acc beforeValueDataobject
				ifNil: [ self basicTypeAccess: acc assertionOn: stream ]
				ifNotNil: [ self dataControlAccess: acc assertionOn: stream ] ]
]

{ #category : #printing }
PWBAccessBasedAssertion >> printPWBScriptOn: stream [
	self printAccessAssertionOn: stream.
	^ stream
]

{ #category : #'as yet unclassified' }
PWBAccessBasedAssertion >> replaceLineBreakWithPwbLinebreak: aString [
	^ (aString copyReplaceAll: String cr with: '')
		copyReplaceAll: String lf
		with: ''
]
