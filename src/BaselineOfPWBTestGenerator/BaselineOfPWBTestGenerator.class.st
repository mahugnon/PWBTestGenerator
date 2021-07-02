Class {
	#name : #BaselineOfPWBTestGenerator,
	#superclass : #BaselineOf,
	#category : #BaselineOfPWBTestGenerator
}

{ #category : #baselines }
BaselineOfPWBTestGenerator >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self
				baselineOfP3: spec;
				baselineOfGlorp: spec;
				baselineOfSmaCC: spec;
				baselineOfPWBTestsDataGenerator: spec.
			spec
				package: 'PWBTestGenerator-Tests';
				package: 'PWBTestGenerator-DataModel'
					with: [ spec requires: #('Glorp' 'P3') ];
				package: 'PWBTestGenerator'
					with: [ spec requires: #('PWBTestsDataGenerator' 'Glorp' 'P3') ] ]
]

{ #category : #baselines }
BaselineOfPWBTestGenerator >> baselineOfGlorp: spec [
	spec
		baseline: 'Glorp'
		with: [ spec repository: 'github://mahugnon/glorp:master' ]
]

{ #category : #baselines }
BaselineOfPWBTestGenerator >> baselineOfP3: spec [
	spec
		baseline: 'P3'
		with: [ spec
				loads: #('glorp');
				repository: 'github://mahugnon/P3:master' ].
	"PharoDatabaseAccessor DefaultDriver: P3DatabaseDriver"
]

{ #category : #baselines }
BaselineOfPWBTestGenerator >> baselineOfPWBTestsDataGenerator: spec [
	spec
		baseline: 'PWBTestsDataGenerator'
		with: [ spec repository: 'github://mahugnon/PWBTestsDataGenerator:main' ]
]

{ #category : #baselines }
BaselineOfPWBTestGenerator >> baselineOfSmaCC: spec [
	spec
		baseline: 'SmaCC'
		with: [ spec repository: 'github://mahugnon/SmaCC' ]
]
