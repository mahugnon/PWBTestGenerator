Class {
	#name : #PWBTestEventGenerator,
	#superclass : #Object,
	#instVars : [
		'mrlBehavior'
	],
	#category : #'PWBTestGenerator-Core'
}

{ #category : #visiting }
PWBTestEventGenerator class >> accept: aFamixPWBInvocation [
	^ self subclassResponsibility
]

{ #category : #visiting }
PWBTestEventGenerator class >> acceptFunction: aFamixPWBFunction [
	^ self subclassResponsibility
]

{ #category : #printing }
PWBTestEventGenerator >> behaviorInvocationTimestamp: timestamp on: stream [
	PWBTestBehaviorCreator behaviorInvocation: mrlBehavior on: stream
]

{ #category : #printing }
PWBTestEventGenerator >> footerEventOn: stream [
	stream  << 'end event'
]

{ #category : #printing }
PWBTestEventGenerator >> headerEventOn: stream [
	^ stream
		<< 'event';
		space;
		<< 'test_';
		<< mrlBehavior behavior_name;
		<< '();';
		crlf;
		crlf
]

{ #category : #printing }
PWBTestEventGenerator >> instanceVariableAssertTimestamp: timestamp on: stream [
	mrlBehavior mrlBehaviorDatas
		do: [ :data | 
			data timestamp = timestamp
				ifTrue: [ data mrlInstanceVariablesAccesses
						do:
							[ :acc | PWBTestInstanceVariableAssertCreator access: acc on: stream ] ] ]
]

{ #category : #printing }
PWBTestEventGenerator >> instanceVariableInitializationTimestamp: timestamp on: stream [
	mrlBehavior mrlBehaviorDatas
		do: [ :data | 
			data timestamp = timestamp
				ifTrue: [ data mrlInstanceVariablesAccesses
						do: [ :acc | PWBTestInstanceVariableCreator access: acc on: stream ] ] ]
]

{ #category : #accessors }
PWBTestEventGenerator >> mrlBehavior: aMrlBehavior [ 
	mrlBehavior := aMrlBehavior
]

{ #category : #printing }
PWBTestEventGenerator >> ownerObjectOn: stream [
	PWBTestObjectCreator
		objectNamed: mrlBehavior pwb_object
		on: stream
]

{ #category : #printing }
PWBTestEventGenerator >> parameterAssertTimestamp: timestamp on: stream [
self flag: #todo
]

{ #category : #printing }
PWBTestEventGenerator >> parameterDeclarationOn: stream [
	mrlBehavior behaviorUnderTest parameters
		do: [ :param | 
			param isPWBDataWindow
				ifTrue:
					[ "In protect we have only one datawindow parameter" 
					PWBTestObjectCreator objectNamed: 'w_PBUnitTest_window' on: stream ]
				ifFalse: [ stream
						<< param parameterType name;
						space;
						<< 'l';
						<< (param name copyFrom: 2 to: param name size);
						crlf ] ]
]

{ #category : #printing }
PWBTestEventGenerator >> parameterInitializationTimestamp: timestamp on: stream [
	mrlBehavior mrlBehaviorDatas
		do: [ :data | 
			data timestamp = timestamp
				ifTrue: [ data mrlParameters
						do: [ :param | PWBTestParameterCreator param: param on: stream ] ] ]
]

{ #category : #printing }
PWBTestEventGenerator >> printPWBScriptOn: stream [
	self headerEventOn: stream.
	self ownerObjectOn: stream.
	self parameterDeclarationOn: stream.
	self returnDeclarationOn: stream.
	mrlBehavior timestamps
		do:
			[ :timestamp | self printPWBScriptTimestamp: timestamp on: stream ].
	self footerEventOn: stream.
	^ stream
]

{ #category : #printing }
PWBTestEventGenerator >> printPWBScriptTimestamp: timestamp on: stream [
	self instanceVariableInitializationTimestamp: timestamp on: stream.
	self parameterInitializationTimestamp: timestamp on: stream.
	self behaviorInvocationTimestamp: timestamp on: stream.
	self parameterAssertTimestamp: timestamp on: stream.
	self instanceVariableAssertTimestamp: timestamp on: stream.
	self returnAssertTimestamp: timestamp on: stream
]

{ #category : #printing }
PWBTestEventGenerator >> return: return on: stream [
	return mrlValue
		ifNil: [ stream
				<< 'this.assert(';
				space;
				<< 'IsNull(';
				space;
				<< 'l_result';
				space;
				nextPut: $);
				nextPut: $);
				crlf ]
		ifNotNil: [ stream
				<< 'this.assert(';
				space;
				<<
					(PWBVariableInitializer
						printValue: return mrlValue
						ofType: mrlBehavior returnType);
				space;
				<< '=';
				space;
				<< 'l_result';
				nextPut: $);
				crlf ]
]

{ #category : #printing }
PWBTestEventGenerator >> returnAssertTimestamp: timestamp on: stream [
	mrlBehavior mrlBehaviorDatas
		do: [ :data | 
			data timestamp = timestamp
				ifTrue: [ data mrlReturnValues
						do: [ :return | self return: return on: stream ] ] ]
]

{ #category : #printing }
PWBTestEventGenerator >> returnDeclarationOn: stream [
	stream
		<< mrlBehavior returnType;
		space;
		<< 'l_result';
		crlf
]
