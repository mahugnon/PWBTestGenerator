Class {
	#name : #PWBTestBehaviorCreator,
	#superclass : #Object,
	#category : #'PWBTestGenerator-PWBTestCase'
}

{ #category : #'as yet unclassified' }
PWBTestBehaviorCreator class >> accept: mrlBehavior [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBTestBehaviorCreator class >> behaviorInvocation: mrlBehavior on: stream [
	^ (self subclasses detect: [ :sub | sub accept: mrlBehavior ]) new
		behaviorInvocation: mrlBehavior
		on: stream
]

{ #category : #'as yet unclassified' }
PWBTestBehaviorCreator >> behaviorInvocation: mrlBehavior on: stream [
	self subclassResponsibility
]

{ #category : #printing }
PWBTestBehaviorCreator >> behaviorWithParams: mrlBehavior on: stream [
	| param parameters |
	parameters := mrlBehavior behaviorUnderTest parameters
		sortAscending: [ :aParam | aParam sourceAnchor startPos ].
	stream
		<< mrlBehavior behavior_name;
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
