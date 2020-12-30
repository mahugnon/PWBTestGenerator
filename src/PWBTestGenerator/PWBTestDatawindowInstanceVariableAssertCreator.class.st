Class {
	#name : #PWBTestDatawindowInstanceVariableAssertCreator,
	#superclass : #PWBTestInstanceVariableAssertCreator,
	#category : #'PWBTestGenerator-Core'
}

{ #category : #'as yet unclassified' }
PWBTestDatawindowInstanceVariableAssertCreator class >> accept: anAccess [
	^ anAccess beforeValueDataobject isEmptyOrNil not
]

{ #category : #'as yet unclassified' }
PWBTestDatawindowInstanceVariableAssertCreator >> access: aMrlInstanceVariableAccess on: stream [
	stream
		<< 'this.assert(';
		<< aMrlInstanceVariableAccess pwbTestVariableName;
		<< '.dataobject = "';
		<< aMrlInstanceVariableAccess afterValueDataobject;
		<< '")';
		crlf.
	stream
		<< 'this.assert(f_get_datacontrol_content(';
		<< aMrlInstanceVariableAccess pwbTestVariableName;
		<< ') = "';
		<<
			(self
				replaceLineBreakWithPwbLinebreak: aMrlInstanceVariableAccess afterValue mrlvalue);
		<< '")';
		crlf
]

{ #category : #'as yet unclassified' }
PWBTestDatawindowInstanceVariableAssertCreator >> replaceLineBreakWithPwbLinebreak: aString [
	"Remove cr the avoid PWB errors"

	^ (aString copyReplaceAll: String cr with: '')
		copyReplaceAll: String lf
		with: ''
]
