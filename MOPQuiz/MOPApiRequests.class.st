Class {
	#name : #MOPApiRequests,
	#superclass : #Object,
	#instVars : [
		'url',
		'port'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #creating }
MOPApiRequests >> createAnswer: aString isRight: aBool forQuestion: aQuestionId [

	| response |
	response := ZnClient new
		url: url, '/question/', aQuestionId asString, '/answer';
		formAt: 'text' put: aString;
		formAt: 'isRight' put: aBool asString;
		post.
		
	response ifNil: [ ^ OrderedCollection new ].
	
	^ (STONReader on: response readStream) next
		
	
]

{ #category : #creating }
MOPApiRequests >> createQuestionWithText: aText withType: aType forQuiz: aQuizId [

	| response |
	response := ZnClient new
		url: url, '/quiz/', aQuizId asString, '/question';
		formAt: 'text' add: aText;
		formAt: 'type' add: aType asString;
		post.
		
	response
		ifNil: [ ^ OrderedCollection new ].
		
	^ (STONReader on: response readStream) next
		
	
]

{ #category : #creating }
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

{ #category : #deleting }
MOPApiRequests >> deleteAnswerWithId: anAnswerId forQuestion: aQuestionId [

	| response |
	response := ZnClient new
		url: url, '/question/', aQuestionId asString, '/answer/', anAnswerId asString;
		delete.
	
	response ifNil: [ ^ OrderedCollection new ].
	
	^ (STONReader on: response readStream) next.
]

{ #category : #deleting }
MOPApiRequests >> deleteQuestionWithId: aQuestionId quiz: aQuizId [

	| response |
	response := ZnClient new
		url: url, '/quiz/', aQuizId asString, '/question/', aQuestionId asString;
		delete.
		
	^ (STONReader on: response readStream) next
]

{ #category : #deleting }
MOPApiRequests >> deleteQuizWithId: anInteger [

	| response |
	response := ZnClient new
		url: url, '/quiz/', anInteger asString;
		delete.
		
	^ (STONReader on: response readStream) next
]

{ #category : #reading }
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
