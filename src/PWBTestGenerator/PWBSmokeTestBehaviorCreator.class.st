Class {
	#name : #PWBSmokeTestBehaviorCreator,
	#superclass : #Object,
	#category : #'PWBTestGenerator-SmokeTests'
}

{ #category : #'as yet unclassified' }
PWBSmokeTestBehaviorCreator class >> accept: mrlBehavior [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBSmokeTestBehaviorCreator class >> behaviorInvocation: mrlBehavior on: stream [
	^ (self subclasses detect: [ :sub | sub accept: mrlBehavior ]) new
		behaviorInvocation: mrlBehavior
		on: stream
]

{ #category : #'as yet unclassified' }
PWBSmokeTestBehaviorCreator >> behaviorInvocation: mrlBehavior on: stream [
	self subclassResponsibility
]

{ #category : #printing }
PWBSmokeTestBehaviorCreator >> behaviorWithParams: behavior on: stream [
	| param parameters |
	parameters := behavior parameters
		sortAscending: [ :aParam | aParam sourceAnchor startPos ].
	stream
		<< behavior name;
		nextPut: $(.
	parameters
		ifEmpty: [ ^ stream
				nextPut: $);
				crlf ].
	1 to: parameters size - 1 do: [ :iter | 
		param := parameters at: iter.
		param isPWBDataWindow
			ifTrue: [ stream
					<< 'lw_PBUnitTest_window.dw_before';
					space;
					nextPut: $, ]
			ifFalse: [ stream
					<< 'l';
					<< (param name copyFrom: 2 to: param name size);
					space;
					nextPut: $, ] ].
	param := parameters last.
	param isPWBDataWindow
		ifTrue: [ stream
				<< 'lw_PBUnitTest_window.dw_before';
				nextPut: $) ]
		ifFalse: [ stream
				<< 'l';
				<< (param name copyFrom: 2 to: param name size);
				space;
				nextPut: $) ].
	^ stream crlf
]
