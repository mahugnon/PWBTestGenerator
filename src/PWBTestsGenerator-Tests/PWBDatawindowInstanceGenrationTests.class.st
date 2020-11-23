Class {
	#name : #PWBDatawindowInstanceGenrationTests,
	#superclass : #TestCase,
	#instVars : [
		'mRLDatawindowInstanceGenrator'
	],
	#category : #'PWBTestsGenerator-Tests'
}

{ #category : #running }
PWBDatawindowInstanceGenrationTests >> setUp [
	mRLDatawindowInstanceGenrator := PWBDatawindowInstanceGenrator new
		name: 'dw_dlq'
]

{ #category : #tests }
PWBDatawindowInstanceGenrationTests >> tearDown [ 

]

{ #category : #tests }
PWBDatawindowInstanceGenrationTests >> testCreateDatawindowdlq [
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
