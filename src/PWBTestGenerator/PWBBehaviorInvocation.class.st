Class {
	#name : #PWBBehaviorInvocation,
	#superclass : #PWBTestGeneratorTask,
	#instVars : [
		'behaviorUnderTest',
		'pwbParameters'
	],
	#category : #'PWBTestGenerator-Task'
}

{ #category : #visiting }
PWBBehaviorInvocation class >> accept: aFamixPWBBehavior [
	self subclassResponsibility
]

{ #category : #accessing }
PWBBehaviorInvocation class >> behaviorUnderTest: aFamixPWBBehavior [
	^ (self subclasses detect: [ :sub | sub accept: aFamixPWBBehavior ])
		new behaviorUnderTest: aFamixPWBBehavior
]

{ #category : #accessing }
PWBBehaviorInvocation >> behaviorName [
	^ behaviorUnderTest name
]

{ #category : #accessing }
PWBBehaviorInvocation >> behaviorParent [
	^ behaviorUnderTest parentType name
]

{ #category : #accessing }
PWBBehaviorInvocation >> behaviorUnderTest: aFamixPWBBehavior [
	behaviorUnderTest := aFamixPWBBehavior
]

{ #category : #printing }
PWBBehaviorInvocation >> behaviorWithParamsOn: stream [
	| param |
	stream
		<< self behaviorName;
		nextPut: $(.
	self pwbParameters
		ifEmpty: [ ^ stream
				nextPut: $);
				crlf ].
	1 to: self pwbParameters size - 1 do: [ :iter | 
		param := self pwbParameters at: iter.
		param isPWBDataWindow
			ifTrue: [ stream
					<< 'lw_PBUnitTest_window.dw_before';
					space;
					nextPut: $, ]
			ifFalse: [ stream
					<< 'l';
					<< (param parameter_name copyFrom: 2 to: param parameter_name size);
					space;
					nextPut: $, ] ].
	param := self pwbParameters last.
	param isPWBDataWindow
		ifTrue: [ stream
				<< 'lw_PBUnitTest_window.dw_before';
				nextPut: $) ]
		ifFalse: [ stream
				<< 'l';
				<< (param parameter_name copyFrom: 2 to: param parameter_name size);
				space;
				nextPut: $) ].
	^ stream crlf
]

{ #category : #initialization }
PWBBehaviorInvocation >> initialize [
	super initialize.
	pwbParameters := OrderedCollection new
]

{ #category : #testing }
PWBBehaviorInvocation >> isBehaviorInvocation [
	^ true
]

{ #category : #printing }
PWBBehaviorInvocation >> printPWBScriptOn: stream [
	self subclassResponsibility
]

{ #category : #accessing }
PWBBehaviorInvocation >> priority [
	^ 20
]

{ #category : #accessing }
PWBBehaviorInvocation >> pwbParameters [
	^ pwbParameters sortAscending: #startPosition
]

{ #category : #accessing }
PWBBehaviorInvocation >> pwbParameters: anObject [
	pwbParameters := anObject
]
