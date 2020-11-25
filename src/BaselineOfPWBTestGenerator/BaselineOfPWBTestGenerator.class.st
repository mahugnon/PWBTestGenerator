Class {
	#name : #BaselineOfPWBTestGenerator,
	#superclass : #BaselineOf,
	#category : #BaselineOfPWBTestGenerator
}

{ #category : #baselines }
BaselineOfPWBTestGenerator >> baseline: spec [
	<baseline>
	self
		baselineOfP3: spec;
		baselineOfGlorp: spec;
		baselineOfPowerBuilderParser: spec;
		baselineOfSmaCC: spec.
	spec
		for: #common
		do: [ self baselineOfPowerBuilderParser: spec.
			spec
				package: 'Iceberg-ProjectLocator';
				package: 'PWBTestGenerator-Tests';
				package: 'PWBTestGenerator-DataModel'
					with: [ spec requires: #('Glorp' 'P3') ];
				package: 'PWBTestGenerator'
					with: [ spec requires: #('PowerBuilderParser' 'Glorp' 'P3') ] ]
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
		with:
			[ spec repository: 'github://mahugnon/PWBTestsDataGenerator:master' ]
]

{ #category : #baselines }
BaselineOfPWBTestGenerator >> baselineOfPowerBuilderParser: spec [
	spec
		baseline: 'PowerBuilderParser'
		with: [ spec
				repository: 'github://moosetechnology/PowerBuilderParser:master' ]
]

{ #category : #baselines }
BaselineOfPWBTestGenerator >> baselineOfSmaCC: spec [
	spec
		baseline: 'SmaCC'
		with: [ spec repository: 'github://mahugnon/SmaCC' ]
]
