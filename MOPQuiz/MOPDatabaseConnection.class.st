Class {
	#name : #MOPDatabaseConnection,
	#superclass : #Object,
	#instVars : [
		'session'
	],
	#classVars : [
		'instance'
	],
	#category : #'MOPQuiz-db'
}

{ #category : #accessing }
MOPDatabaseConnection class >> instance [

	instance
		ifNil: [ instance := self new ].
	
	^ instance
]

{ #category : #accessing }
MOPDatabaseConnection class >> resetSession [

	instance := nil
]

{ #category : #initialization }
MOPDatabaseConnection >> createAnswer: aString isRight: aStringIsRight forQuestion: aQuestionId [

	| question |
	question := session readOneOf: MOPQuestion where: [ :q | q questionId = aQuestionId  ].
	question ifNil: [ ^ OrderedCollection new ].
	
	session inUnitOfWorkDo: [ 
		| newAnswer |
		newAnswer := MOPAnswer new
			text: aString;
			isRight: (self stringToBool: aStringIsRight).
		session register: newAnswer.
		question answers add: newAnswer.
		session register: question ].
	
	^ question answers
]

{ #category : #initialization }
MOPDatabaseConnection >> createQuestionWithText: aString withType: anInteger forQuiz: aQuizId [

	| quiz |
	quiz := session readOneOf: MOPQuiz where: [ :q | q quizId = aQuizId ].
	quiz ifNil: [ ^ OrderedCollection new ].
	
	session inUnitOfWorkDo: [
		| newQuestion |
		newQuestion := MOPQuestion new
			text: aString;
			type: anInteger.
		session register: newQuestion. 
		quiz questions add: newQuestion.
		session register: quiz ].
		
	^ quiz questions
]

{ #category : #initialization }
MOPDatabaseConnection >> createQuizWithName: aString [

	| newInstance |
	newInstance := MOPQuiz new
		name: aString.
	
	session inUnitOfWorkDo: [ session register: newInstance ]
]

{ #category : #initialization }
MOPDatabaseConnection >> createQuizWithName: aString withDescription: aDescriptionString [

	| newInstance |
	newInstance := MOPQuiz new
		name: aString;
		description: aDescriptionString.
	
	session inUnitOfWorkDo: [ session register: newInstance ].
	^ self getAllQuizes
]

{ #category : #initialization }
MOPDatabaseConnection >> deleteAnswerWithId: anInteger [

	session inUnitOfWorkDo: [ 
		session delete: MOPAnswer where: [ :each | each answerId = anInteger ]	
	]
]

{ #category : #initialization }
MOPDatabaseConnection >> deleteAnswerWithId: anAnswerId forQuestion: aQuestionId [

	| question |
	question := session readOneOf: MOPQuestion where: [ :q | q questionId = aQuestionId ].
	question ifNil: [ ^ OrderedCollection new ].
	
	session inUnitOfWorkDo: [ 
		question answers copy do: [ :each | each answerId = anAnswerId ifTrue: [ question answers remove: each ] ]. 
		session register: question. ]
]

{ #category : #initialization }
MOPDatabaseConnection >> deleteQuestionWithId: anInteger [

	| toDelete |
	toDelete := session readOneOf: MOPQuestion where: [ :q | q questionId = anInteger ].
	toDelete ifNotNil: [ 
		session inUnitOfWorkDo: [
			toDelete answers do: [ :each | session delete: each ].
			session delete: toDelete	] ]
	
]

{ #category : #initialization }
MOPDatabaseConnection >> deleteQuestionWithId: anInteger quizId: aQuizId [

	| quiz |
	self deleteQuestionWithId: anInteger.
	quiz := ((SimpleQuery readOneOf: MOPQuiz where: [ :q | q quizId = aQuizId ])
		shouldRefresh: true) executeIn: session.
	^ quiz questions
	
]

{ #category : #initialization }
MOPDatabaseConnection >> deleteQuizWithId: anInteger [

	session inUnitOfWorkDo: [ 
		session delete: MOPQuiz where: [ :each | each quizId = anInteger ]	
	].

	^ self getAllQuizes
]

{ #category : #initialization }
MOPDatabaseConnection >> getAllQuizes [

	^ ((SimpleQuery read: MOPQuiz) shouldRefresh: true) executeIn: session
]

{ #category : #initialization }
MOPDatabaseConnection >> getQuizWithId: anInteger [

	^ ((SimpleQuery read: MOPQuiz)
		where: [ :each | each quizId = anInteger ]
	) executeIn: session
]

{ #category : #initialization }
MOPDatabaseConnection >> initialize [

	| login |
	login := Login new
		database: PostgreSQLPlatform new;
		username: 'mop_user';
		password: 'mop2020';
		connectString: '127.0.0.1:5432_mop_user';
		encodingStrategy: #utf8;
		databaseName: 'mop'.
		
	session := MOPQuizDescriptorSystem sessionForLogin: login.
	session login
]

{ #category : #initialization }
MOPDatabaseConnection >> recreateTables [

	session recreateTables
]

{ #category : #initialization }
MOPDatabaseConnection >> session [

	^ session
]

{ #category : #initialization }
MOPDatabaseConnection >> stringToBool: aString [

	aString asLowercase = 'true'
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]
