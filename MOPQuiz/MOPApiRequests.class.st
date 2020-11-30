Class {
	#name : #MOPApiRequests,
	#superclass : #Object,
	#instVars : [
		'url',
		'port'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #initialization }
MOPApiRequests >> getAllQuizes [

	| response responseJson |
	response := ZnClient new
		url: url , '/quiz';
		get;
		response.
		
	response
		ifNil: [ ^ OrderedCollection new ].
		
	responseJson := response entity string.
	^ (NeoJSONReader on: responseJson readStream)
		mapInstVarsFor: MOPQuiz;
		for: #ArrayOfMOPQuizes customDo: [ :mapping |
			mapping listOfElementSchema: MOPQuiz ];
		nextAs: #ArrayOfMOPQuizes 	
]

{ #category : #initialization }
MOPApiRequests >> initialize [

	port := '8080'.
	url := 'http://127.0.0.1:', port
]
