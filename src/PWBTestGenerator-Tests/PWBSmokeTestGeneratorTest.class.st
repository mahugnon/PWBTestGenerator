Class {
	#name : #PWBSmokeTestGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'stream',
		'testClass',
		'mrlBehavior',
		'model'
	],
	#category : #'PWBTestGenerator-Tests'
}

{ #category : #accessing }
PWBSmokeTestGeneratorTest >> script [
	^ stream contents copyReplaceAll: String crlf with: String cr
]

{ #category : #running }
PWBSmokeTestGeneratorTest >> setUp [
	stream := WriteStream on: String new.
	model := FamixPWBModel new.
	testClass := PWBSmokeTestGenerator new
]

{ #category : #tests }
PWBSmokeTestGeneratorTest >> testFileDeclaredTypeOn [
	| majorObject |
	majorObject := FamixPWBUserObject named: 'uo_test' model: model.
	(FamixPWBEvent named: 'ue_testEvent' model: model)
		parentType: majorObject.
	testClass majorObject: majorObject.
	testClass fileDeclaredTypeOn: stream.
	self
		assert: self script
		equals:
		'global type test_uo_test_case_generated from testcase
event test_ue_testEvent_smoke_generated ()
end type
global test_uo_test_case_generated test_uo_test_case_generated
'
]

{ #category : #tests }
PWBSmokeTestGeneratorTest >> testFileDeclaredTypeOn1 [
	| majorObject |
	majorObject := FamixPWBUserObject named: 'uo_test' model: model.
	(FamixPWBEvent named: 'ue_testEvent' model: model)
		parentType: majorObject.
	(FamixPWBEvent named: 'ue_testEvent2' model: model)
		parentType: majorObject.
	testClass majorObject: majorObject.
	testClass fileDeclaredTypeOn: stream.
	self
		assert: self script
		equals:
			'global type test_uo_test_case_generated from testcase
event test_ue_testEvent_smoke_generated ()
event test_ue_testEvent2_smoke_generated ()
end type
global test_uo_test_case_generated test_uo_test_case_generated
'
]

{ #category : #tests }
PWBSmokeTestGeneratorTest >> testForwardOn [
	| majorObject |
	majorObject := FamixPWBUserObject named: 'uo_test'.
	testClass majorObject: majorObject.
	testClass forwardOn: stream.
	self
		assert: self script
		equals:
			'forward
global type test_uo_test_case_generated from testcase
end type
end forward
'
]

{ #category : #tests }
PWBSmokeTestGeneratorTest >> testOnCreateOn [
	| majorObject |
	majorObject := FamixPWBUserObject named: 'uo_test'.
	testClass majorObject: majorObject.
	testClass onCreateOn: stream.
	self
		assert: self script
		equals:
			'on test_uo_test_case_generated.create
call super::create
end on'
]

{ #category : #tests }
PWBSmokeTestGeneratorTest >> testOnDestroyOn [
	| majorObject |
	majorObject := FamixPWBUserObject named: 'uo_test'.
	testClass majorObject: majorObject.
	testClass onDestroyOn: stream.
	self
		assert: self script
		equals:
			'on test_uo_test_case_generated.destroy
call super::destroy
end on'
]

{ #category : #tests }
PWBSmokeTestGeneratorTest >> testPrintPWBScriptOn [
	| majorObject |
	majorObject := FamixPWBUserObject named: 'uo_test' model: model.
	(FamixPWBEvent named: 'ue_testEvent' model: model)
		parentType: majorObject.
	(FamixPWBEvent named: 'ue_testEvent2' model: model)
		parentType: majorObject.
	testClass majorObject: majorObject.
	testClass testClassContentOn: stream.
	self
		assert: self script
		equals:
			'$PBExportHeader$test_uo_test_case_generated.sru
forward
global type test_uo_test_case_generated from testcase
end type
end forward
global type test_uo_test_case_generated from testcase
event test_ue_testEvent_smoke_generated ()
event test_ue_testEvent2_smoke_generated ()
end type
global test_uo_test_case_generated test_uo_test_case_generated

event test_ue_testEvent_smoke_generated();

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
end event

event test_ue_testEvent2_smoke_generated();

/*
Ce test est un test généré dans le cadre du projet de la CIM recherche en colaboration avec l''INRIA.
Trouver le projet de generation sur github:https://github.com/mahugnon/PWBTestGenerator.git
La method tester ici est: ue_testEvent2 de uo_test
Autheur: HOUEKPETODJI Mahugnon Honoré
*/

TRY
uo_test luo_test
luo_test = create uo_test
luo_test.triggerEvent("ue_testEvent2")
this.assert(true)
CATCH (runtimeerror er)
this.assert(Er.getmessage(),false)
FINALLY
Destroy luo_test
END TRY
end event

on test_uo_test_case_generated.create
call super::create
end on
on test_uo_test_case_generated.destroy
call super::destroy
end on'
]

{ #category : #tests }
PWBSmokeTestGeneratorTest >> testTestFileHeaderOn [
	| majorObject |
	majorObject := FamixPWBUserObject named: 'uo_test'.
	testClass majorObject: majorObject.
	testClass testFileHeaderOn: stream.
	self
		assert: self script
		equals:
			'$PBExportHeader$test_uo_test_case_generated.sru
'
]
