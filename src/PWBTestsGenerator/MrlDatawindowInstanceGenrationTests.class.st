Class {
	#name : #MrlDatawindowInstanceGenrationTests,
	#superclass : #TestCase,
	#instVars : [
		'mRLDatawindowInstanceGenrator'
	],
	#category : #'PWBTestsGenerator-Tests'
}

{ #category : #running }
MrlDatawindowInstanceGenrationTests >> setUp [
	mRLDatawindowInstanceGenrator := PWBDatawindowInstanceGenrator new
		name: 'dw_dlq'
]

{ #category : #tests }
MrlDatawindowInstanceGenrationTests >> tearDown [ 

]

{ #category : #tests }
MrlDatawindowInstanceGenrationTests >> testCreateDatawindowdlq [
	self
		assert:
			(mRLDatawindowInstanceGenrator initializeDatawindowScript
				copyReplaceAll: String crlf
				with: String cr)
		equals:
			'datawindow dw_dlq
dw_dlq = create datawindow
'
]
