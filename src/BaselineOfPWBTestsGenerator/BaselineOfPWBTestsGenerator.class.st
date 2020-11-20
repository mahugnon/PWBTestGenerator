Class {
	#name : #BaselineOfPWBTestsGenerator,
	#superclass : #BaselineOf,
	#category : #BaselineOfPWBTestsGenerator
}

{ #category : #baselines }
BaselineOfPWBTestsGenerator >> baseline: spec [
	<baseline>
	self
		baselineOfP3: spec;
		baselineOfGlorp: spec.
	spec
		for: #common
		do: [ self baselineOfPowerBuilderParser: spec.
			spec
				package: 'Iceberg-ProjectLocator';
				package: 'PWBTestsDataGenerator-Model'
					with: [ spec requires: #('Glorp' 'P3') ];
				package: 'PWBTestsGenerator'
					with: [ spec requires: #('PowerBuilderParser' 'Glorp' 'P3') ] ]
]

{ #category : #baselines }
BaselineOfPWBTestsGenerator >> baselineOfGlorp: spec [
	spec
		baseline: 'Glorp'
		with: [ spec
				repository: 'github://mahugnon/glorp:32-Glorp-doesnt-support-ssl-connexion-for-P3' ]
]

{ #category : #baselines }
BaselineOfPWBTestsGenerator >> baselineOfP3: spec [
	spec
		baseline: 'P3'
		with: [ spec
				repository: 'github://mahugnon/P3:29-P3DatabaseDriver-should-have-connectSSL' ]
]

{ #category : #baselines }
BaselineOfPWBTestsGenerator >> baselineOfPowerBuilderParser: spec [
	spec
		baseline: 'PowerBuilderParser'
		with: [ spec
				repository: 'github://moosetechnology/PowerBuilderParser:master' ]
]
