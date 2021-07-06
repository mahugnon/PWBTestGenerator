Extension { #name : #FamixPWBWindow }

{ #category : #'*PWBTestGenerator' }
FamixPWBWindow >> closeOn: stream [
	stream
		<< 'close(l';
		<< self name;
		<< ')';
		crlf
]
