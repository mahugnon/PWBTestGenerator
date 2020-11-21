Class {
	#name : #PWBInvocationArgument,
	#superclass : #Object,
	#instVars : [
		'sender',
		'receiver',
		'startPosition',
		'stopPosition',
		'invocationText',
		'argumentName',
		'argumentValue',
		'invocationLineNumber',
		'file'
	],
	#category : #PWBTestsGenerator
}

{ #category : #accessing }
PWBInvocationArgument >> argumentName [
	^ argumentName
]

{ #category : #accessing }
PWBInvocationArgument >> argumentName: anObject [
	argumentName := anObject
]

{ #category : #accessing }
PWBInvocationArgument >> argumentValue [
	^ argumentValue
]

{ #category : #accessing }
PWBInvocationArgument >> argumentValue: anObject [
	argumentValue := anObject
]

{ #category : #accessing }
PWBInvocationArgument >> file [
	file
		ifNil: [ file := sender sourceAnchor rootFolder asFileReference
				resolve: sender sourceAnchor fileName ].
	^ file
]

{ #category : #api }
PWBInvocationArgument >> generateInSourceTextMrlLogStrings [
	| beforeSenderText afterSenderText senderText |
	self flag: #toRemove.
	beforeSenderText := file contents
		copyFrom: 1
		to: sender sourceAnchor startPos - 1.
	sender sourceAnchor endPos >= file contents size
		ifTrue: [ afterSenderText := '' ]
		ifFalse: [ afterSenderText := file contents
				copyFrom: sender sourceAnchor endPos + 1
				to: file contents size ].
	senderText := file contents
		copyFrom: sender sourceAnchor startPos
		to: sender sourceAnchor endPos.
	senderText := self insertMrlLogStringsIn: senderText.
	^ String
		streamContents: [ :aStream | 
			aStream
				<< beforeSenderText;
				<< senderText;
				<< afterSenderText ]
]

{ #category : #api }
PWBInvocationArgument >> generateInSourceTextMrlLogStrings: aString [
	| newSenderText |
	newSenderText := aString copy.
	(self invocationLines: aString)
		do: [ :aLine | 
			| mrlString |
			mrlString := self mrlLogStringsFor: aLine.
			newSenderText := (newSenderText includesSubstring: mrlString)
				ifTrue: [ newSenderText copyReplaceAll: mrlString with: mrlString ]
				ifFalse: [ newSenderText copyReplaceAll: aLine with: mrlString ] ].
	^ newSenderText
]

{ #category : #api }
PWBInvocationArgument >> insertMrlLogStringsIn: aString [
	| result |
	(self invocationLines: aString)
		do: [ :aLine | 
			result := aString
				copyReplaceAll: aLine
				with: (self mrlLogStringsFor: aLine) ].
	^ result
]

{ #category : #accessing }
PWBInvocationArgument >> invocationLineNumber [
	^ invocationLineNumber
]

{ #category : #accessing }
PWBInvocationArgument >> invocationLineNumber: anObject [
	invocationLineNumber := anObject
]

{ #category : #api }
PWBInvocationArgument >> invocationLines: sourceText [
	^ QueryInsertMrlCodeLines new
		runOn: sourceText
		with: self invocationText
]

{ #category : #accessing }
PWBInvocationArgument >> invocationText [
	^ invocationText
]

{ #category : #accessing }
PWBInvocationArgument >> invocationText: anObject [
	invocationText := anObject
]

{ #category : #api }
PWBInvocationArgument >> mrlAfterLogString [
	^self mrlLogString: 'after'
]

{ #category : #api }
PWBInvocationArgument >> mrlBeforeLogString [
	^ self mrlLogString: 'before'
]

{ #category : #api }
PWBInvocationArgument >> mrlLogString: aString [
	| printable |
	printable := argumentName copy.
	self replacementMap keys
		select: [ :key | printable includesSubstring: key asString ]
		thenDo: [ :key | 
			printable := printable
				copyReplaceAll: key asString
				with: (self replacementMap at: key) ].
	^ String
		streamContents: [ :aStream | 
			aStream
				<< 'f_mrl_logger().invocation_parameter_logger().log(';
				<< argumentValue;
				<< ',';
				<< '"';
				<< sender name;
				<< '"';
				<< ',';
				<< '"';
				<< sender parentType name;
				<< '-';
				<< invocationLineNumber asString;
				<< '-';
				<< printable;
				<< '-';
				<< aString;
				<< '-';
				<< receiver;
				<< '"';
				<< ')' ]
]

{ #category : #api }
PWBInvocationArgument >> mrlLogStringsFor: aLine [
	^ String
		streamContents: [ :aStream | 
			aStream
				<< self mrlBeforeLogString;
				crlf;
				<< aLine;
				crlf";
				<< self mrlAfterLogString" ]
]

{ #category : #accessing }
PWBInvocationArgument >> receiver [
	^ receiver
]

{ #category : #accessing }
PWBInvocationArgument >> receiver: anObject [
	receiver := anObject
]

{ #category : #api }
PWBInvocationArgument >> replacementMap [
	^ {('/' -> '_dividedBy_').
	('<>' -> '_isDifferentFrom_').
	($" -> '').
	($' -> '').
	(' ' -> '').
	('""' -> 'empty_string')} asOrderedDictionary
]

{ #category : #api }
PWBInvocationArgument >> saveMrlLogStrings [
	| file beforeSenderText afterSenderText senderText initSize |
	file := sender sourceAnchor rootFolder asFileReference
		resolve: sender sourceAnchor fileName.
	beforeSenderText := file contents
		copyFrom: 1
		to: sender sourceAnchor startPos - 1.
	sender sourceAnchor endPos >= file contents size
		ifTrue: [ afterSenderText := '' ]
		ifFalse: [ afterSenderText := file contents
				copyFrom: sender sourceAnchor endPos + 1
				to: file contents size ].
	senderText := file contents
		copyFrom: sender sourceAnchor startPos
		to: sender sourceAnchor endPos.
	initSize := senderText size.
	senderText := self insertMrlLogStringsIn: senderText.
	file
		writeStreamDo: [ :aStream | 
			aStream
				<< beforeSenderText;
				<< senderText;
				<< afterSenderText ].
	sender addedCharacter: senderText size - initSize.
	sender sourceAnchor
		endPos: sender sourceAnchor startPos + senderText size - 1
]

{ #category : #accessing }
PWBInvocationArgument >> sender [
	^ sender
]

{ #category : #accessing }
PWBInvocationArgument >> sender: anObject [
	sender := anObject
]

{ #category : #accessing }
PWBInvocationArgument >> startPosition [
	^ startPosition
]

{ #category : #accessing }
PWBInvocationArgument >> startPosition: anObject [
	startPosition := anObject
]

{ #category : #accessing }
PWBInvocationArgument >> stopPosition [
	^ stopPosition
]

{ #category : #accessing }
PWBInvocationArgument >> stopPosition: anObject [
	stopPosition := anObject
]
