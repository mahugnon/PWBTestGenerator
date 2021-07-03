Class {
	#name : #PWBSmokeTestEventGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'testEventGenerator',
		'stream',
		'model',
		'behavior'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> script [
	^ stream contents copyReplaceAll: String crlf with: String cr
]

{ #category : #running }
PWBSmokeTestEventGeneratorTest >> setUp [
	stream := WriteStream on: String new.
	model := FamixPWBModel new.
	testEventGenerator := PWBSmokeTestEventGenerator new.
	behavior := FamixPWBEvent named: 'ue_testEvent' model: model.
	testEventGenerator behavior: behavior
]

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> testBeginTryOn [
	testEventGenerator beginTryOn: stream.
	self assert: self script equals:'TRY
'
]

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> testBehaviorInvocationOn [
	behavior
		parentType: (FamixPWBUserObject named: 'uo_test' model: model).
	testEventGenerator behaviorInvocationOn: stream.
	self
		assert: self script
		equals:
			'luo_test.triggerEvent("ue_testEvent")
'
]

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> testBehaviorInvocationOn2 [
	self skip.
	behavior := FamixPWBSubRoutine named: 'uf_test' model: model.
	behavior accessModifier: 'public'.
	behavior
		parentType: (FamixPWBUserObject named: 'uo_test' model: model).
	testEventGenerator behavior: behavior.
	testEventGenerator behaviorInvocationOn: stream.
	self
		assert: self script
		equals:
			'luo_test.triggerEvent("ue_testEvent")
'
]

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> testEndTryOn [
	behavior
		parentType: (FamixPWBUserObject named: 'uo_test' model: model).
	testEventGenerator endTryOn: stream.
	self
		assert: self script
		equals:
	'CATCH (runtimeerror er)
this.assert(Er.getmessage(),false)
FINALLY
Destroy luo_test
END TRY
'
]

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> testFooterEventOn [
	testEventGenerator footerEventOn: stream.
	self assert: self script equals: 'end event'
]

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> testGenericCommentOn [
	self skip.
	behavior
		parentType: (FamixPWBUserObject named: 'uo_test' model: model).
	testEventGenerator genericCommentOn: stream.
	self
		assert: self script
		equals:
		'/*
Ce test est un test généré dans le cadre du projet de la CIM recherche en colaboration avec l''INRIA.
Trouver le projet de generation sur github:https://github.com/mahugnon/PWBTestGenerator.git
La method tester ici est: ue_testEvent de uo_test
Autheur: HOUEKPETODJI Mahugnon Honoré
*/

'
]

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> testPrintPWBScriptOn [
	behavior
		parentType: (FamixPWBUserObject named: 'uo_test' model: model).
	testEventGenerator printPWBScriptOn: stream.
	self
		assert: self script
		equals:
			'event test_ue_testEvent_smoke_generated();

/*
Ce test est un test généré dans le cadre du projet de la CIM recherche en colaboration avec l''INRIA.
Trouver le projet de generation sur github:https://github.com/mahugnon/PWBTestGenerator.git
La method tester ici est: ue_testEvent de uo_test
Autheur: HOUEKPETODJI Mahugnon Honoré
*/

TRY
uo_test luo_test
luo_test = create uo_test
luo_test.triggerEvent("ue_testEvent")
this.assert(true)
CATCH (runtimeerror er)
this.assert(Er.getmessage(),false)
FINALLY
Destroy luo_test
END TRY
end event'
]

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> testPrintPWBScriptOn2 [
self skip
	behavior
		parentType: (FamixPWBUserObject named: 'uo_test' model: model).
	testEventGenerator printPWBScriptOn: stream.
	self
		assert: self script
		equals:
			'event test_ue_testEvent_smoke_generated();

/*
Ce test est un test généré dans le cadre du projet de la CIM recherche en colaboration avec l''INRIA.
Trouver le projet de generation sur github:https://github.com/mahugnon/PWBTestGenerator.git
La method tester ici est: ue_testEvent de uo_test
Autheur: HOUEKPETODJI Mahugnon Honoré
*/

TRY
uo_test luo_test
luo_test = create uo_test
luo_test.triggerEvent("ue_testEvent")
this.assert(true)
CATCH (runtimeerror er)
this.assert(Er.getmessage(),false)
FINALLY
Destroy luo_test
END TRY
end event'
]

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> testSmokeAssertOn [
	testEventGenerator smokeAssertOn: stream.
	self
		assert: self script
		equals:
		'this.assert(true)
'
]

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> testUserObjectBehaviorOwnerOn [
	behavior
		parentType: (FamixPWBUserObject named: 'uo_test' model: model).
	testEventGenerator ownerObjectOn: stream.
	self
		assert: self script
		equals:
			'uo_test luo_test
luo_test = create uo_test
'
]

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> testWindowBehaviorOwnerOn [
	behavior
		parentType: (FamixPWBDataWindow named: 'w_test_window' model: model).
	testEventGenerator ownerObjectOn: stream.
	self
		assert: self script
		equals:
		'w_test_window lw_test_window
open(lw_test_window)
lw_test_window.hide()
'
]

{ #category : #tests }
PWBSmokeTestEventGeneratorTest >> testheaderEventOn [
	testEventGenerator headerEventOn: stream.
	self
		assert: self script
		equals:
			'event test_ue_testEvent_smoke_generated();

'
]
