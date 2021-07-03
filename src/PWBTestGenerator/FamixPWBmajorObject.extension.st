Extension { #name : #FamixPWBmajorObject }

{ #category : #'*PWBTestGenerator' }
FamixPWBmajorObject >> behaviorToTest [
	| list finalList |
	finalList := OrderedCollection new.
	list := self methods
		select: [ :e | e isEvent and: [ e name ~= 'constructor' ] ].
	list
		do: [ :each | 
			(finalList anySatisfy: [ :e | e name = each name ])
				ifFalse: [ finalList add: each ] ].
	^ finalList
]
