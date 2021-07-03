Extension { #name : #FamixPWBUserObject }

{ #category : #'*PWBTestGenerator' }
FamixPWBUserObject >> behaviorToTest [
	^ self methods
		select: [ :e | e isEvent and: [ e name ~= 'constructor' ] ]
]
