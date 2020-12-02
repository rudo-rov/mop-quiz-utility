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

	| response |
	response := ZnClient new
		url: url, '/quiz';
		formAt: 'name' put: aName;
		formAt: 'description' put: aDescription;
		post.
		
	response
		ifNil: [ ^ OrderedCollection new ].
		
	^ (STONReader on: response readStream) next
		
	
]

{ #category : #initialization }
MOPApiRequests >> deleteQuestionWithId: aQuestionId quiz: aQuizId [

	| response |
	response := ZnClient new
		url: url, '/quiz/', aQuizId asString, '/question/', aQuestionId asString;
		delete.
		
	^ (STONReader on: response readStream) next
]

{ #category : #initialization }
MOPApiRequests >> deleteQuizWithId: anInteger [

	| response |
	response := ZnClient new
		url: url, '/quiz/', anInteger asString;
		delete.
		
	^ (STONReader on: response readStream) next
]

{ #category : #initialization }
MOPApiRequests >> getAllQuizes [

	| response  |
	response := ZnClient new
		url: url , '/quiz';
		get.
		
	response
		ifNil: [ ^ OrderedCollection new ].
		
	^ ((STONReader on: response readStream) next)
]

{ #category : #initialization }
MOPApiRequests >> initialize [

	port := '8080'.
	url := 'http://127.0.0.1:', port
]
