Class {
	#name : #PWBJobs,
	#superclass : #Object,
	#instVars : [
		'izyProtectTarget'
	],
	#category : #PWBTestsGenerator
}

{ #category : #accessing }
PWBJobs >> izyProtectRootFolder [
	^ izyProtectTarget parent
]
