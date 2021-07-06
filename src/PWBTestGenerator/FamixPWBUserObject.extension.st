Extension { #name : #FamixPWBUserObject }

{ #category : #'*PWBTestGenerator' }
FamixPWBUserObject >> closeOn: stream [
	stream
		<< 'destroy l';
		<< self name;
		crlf
]
