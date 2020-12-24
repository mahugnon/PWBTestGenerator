"
I am related to a PBObject. I have
- a setup method
- one to many testMethods 

"
Class {
	#name : #PWBTestClass,
	#superclass : #Object,
	#instVars : [
		'steps',
		'testMethods',
		'pwbObject'
	],
	#category : #'PWBTestGenerator-PWBTestSuite'
}

{ #category : #'as yet unclassified' }
PWBTestClass class >> generateForModel: aFamixPWBModel in: aFolder [
	aFamixPWBModel getBusinessRuleFunctions
		keysDo:
			[ :pwbObject | self new pwbObject: pwbObject generateTestIn: aFolder ]
]

{ #category : #'as yet unclassified' }
PWBTestClass >> beginSteps [
	^ (self steps select: [ :each | each priority <= 5 ])
		sortAscending: #priority
]

{ #category : #'as yet unclassified' }
PWBTestClass >> createDefautSteps [
	steps add: (PWBFileHeaderStep setUpStepFor: pwbObject name).
	steps add: (PWBForwardStep setUpStepFor: pwbObject name).
	steps
		add:
			((PWBDeclaredTypeStep setUpStepFor: pwbObject name)
				testMethodsNames: self testMethodsNames).
	steps add: (PWBOnCreateStep setUpStepFor: pwbObject name).
	steps add: (PWBTypeVariablesStep setUpStepFor: pwbObject name).
	steps add: (PWBOnDestroyStep setUpStepFor: pwbObject name)
]

{ #category : #'as yet unclassified' }
PWBTestClass >> createSetUp [
	steps add: (PWBCreateTestObjectTask setUpStepFor: pwbObject name)
]

{ #category : #'as yet unclassified' }
PWBTestClass >> createSteps [
	self testMethods do: #createSteps.
	self createDefautSteps.
	self createSetUp
]

{ #category : #'as yet unclassified' }
PWBTestClass >> endSteps [
	^ (self steps select: [ :each | each priority >= 100 ])
		sortAscending: #priority
]

{ #category : #initialization }
PWBTestClass >> initialize [
	steps := OrderedCollection new
]

{ #category : #accessing }
PWBTestClass >> pwbObject [
	^ pwbObject
]

{ #category : #accessing }
PWBTestClass >> pwbObject: anObject [
	pwbObject := anObject
]

{ #category : #accessing }
PWBTestClass >> pwbObject: aPwbObject generateTestIn: aFolder [
	pwbObject := aPwbObject.
	testMethods := (self testableBehaviors
		collect: [ :famixBehavior | PWBTestMethod unitTestForFunction: famixBehavior ])
		select: [ :m | m hasAssertions ].
	self createSteps.
	self runStepsOn: aFolder
]

{ #category : #'as yet unclassified' }
PWBTestClass >> runStepsOn: aFolder [
	(aFolder asFileReference / (self pwbObject name , '.sru'))
		ensureCreateFile;
		writeStreamDo: [ :stream | 
			self beginSteps do: [ :step | step printPWBScriptOn: stream ].
			self testMethods do: [ :m | m printPWBScriptOn: stream ].
			self endSteps do: [ :step | step printPWBScriptOn: stream ] ]
]

{ #category : #accessing }
PWBTestClass >> steps [
	^ steps
]

{ #category : #accessing }
PWBTestClass >> steps: anObject [
	steps := anObject
]

{ #category : #accessing }
PWBTestClass >> testMethods [
	^ testMethods
]

{ #category : #accessing }
PWBTestClass >> testMethods: anObject [
	testMethods := anObject
]

{ #category : #accessing }
PWBTestClass >> testMethodsNames [
	^ self testMethods collect: #name
]

{ #category : #'as yet unclassified' }
PWBTestClass >> testableBehaviors [
	^ pwbObject getBusinessRuleFunctions
		reject: [ :each | each isPrivate ]
]
