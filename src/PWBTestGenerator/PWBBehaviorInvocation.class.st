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

{ #category : #printing }
PWBBehaviorInvocation >> printPWBScriptOn: stream [
	self subclassResponsibility
]
