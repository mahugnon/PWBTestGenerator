Extension { #name : #FamixPWBUserObject }

{ #category : #'*PWBTestGenerator' }
FamixPWBUserObject >> closeOn: stream [
	stream
		<< 'w_app_mdi.closeUserObject(l';
		<< self name;
		nextPut: $);
		crlf
]
