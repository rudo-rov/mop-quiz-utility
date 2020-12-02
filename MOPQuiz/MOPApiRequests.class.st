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
MOPApiRequests >> createQuizWithName: aName withDescription: aDescription [

	| response responseJson |
	response := ZnClient new
		url: url, '/quiz';
		formAt: 'name' put: aName;
		formAt: 'description' put: aDescription;
		post;
		response.
		
	response
		ifNil: [ ^ OrderedCollection new ].
		
	responseJson := response entity string.
	^ (NeoJSONReader on: responseJson readStream)
		mapInstVarsFor: MOPQuiz;
		for: #ArrayOfMOPQuiz customDo: [ :mapping |
			mapping listOfElementSchema: MOPQuiz ];
		nextAs: #ArrayOfMOPQuiz
		
	
]

{ #category : #initialization }
MOPApiRequests >> deleteQuizWithId: anInteger [

	| response responseJson |
	response := ZnClient new
		url: url, '/quiz/', anInteger asString;
		delete;
		response.
		
	responseJson := response entity string.
	^ (NeoJSONReader on: responseJson readStream)
		mapInstVarsFor: MOPQuiz;
		for: #ArrayOfMOPQuizes customDo: [ :mapping |
			mapping listOfElementSchema: MOPQuiz ];
		nextAs: #ArrayOfMOPQuizes	
]

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
