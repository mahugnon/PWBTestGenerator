Class {
	#name : #PWBCreateTestObjectTaskTest,
	#superclass : #PWBAbstractTestGenerationTest,
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #tests }
PWBCreateTestObjectTaskTest >> testCreateGlobalFunction [
	| script |
	script := String
		streamContents:
			[ :stream | PWBCreateTestObjectTask createAndInitialize: 'f_myglobal' on: stream ].
	self assert: script isEmpty
]

{ #category : #tests }
PWBCreateTestObjectTaskTest >> testCreateNonVisualObject [
	| script |
	script := String
		streamContents:
			[ :stream | PWBCreateTestObjectTask createAndInitialize: 'uo_liq_cal' on: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'uo_liq_cal luo_liq_cal
luo_liq_cal = create uo_liq_cal
'
]

{ #category : #tests }
PWBCreateTestObjectTaskTest >> testCreateVisualObject [
	| script |
	script := String
		streamContents: [ :stream | 
			PWBCreateTestObjectTask
				createAndInitialize: 'w_saisie_liquidation'
				on: stream ].
	self
		assert: (script copyReplaceAll: String crlf with: String cr)
		equals:
			'w_saisie_liquidation lw_saisie_liquidation
open(lw_saisie_liquidation)
lw_saisie_liquidation.hide()
'
]
