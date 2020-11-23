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
		baselineOfPowerBuilderParser: spec.
	spec
		for: #common
		do: [ self baselineOfPowerBuilderParser: spec.
			spec
				package: 'Iceberg-ProjectLocator';
				package: 'PWBTestsGenerator-DataModel'
					with: [ spec requires: #('Glorp' 'P3') ];
				package: 'PWBTestsGenerator'
					with: [ spec requires: #('PowerBuilderParser' 'Glorp' 'P3') ] ]
]

{ #category : #baselines }
BaselineOfPWBTestGenerator >> baselineOfGlorp: spec [
	spec
		baseline: 'Glorp'
		with: [ spec
				repository: 'github://mahugnon/glorp:32-Glorp-doesnt-support-ssl-connexion-for-P3' ]
]

{ #category : #baselines }
BaselineOfPWBTestGenerator >> baselineOfP3: spec [
	spec
		baseline: 'P3'
		with: [ spec
				repository: 'github://mahugnon/P3:29-P3DatabaseDriver-should-have-connectSSL' ]
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
		with: [ spec repository: 'github://SmaCCRefactoring/SmaCC' ]
]
