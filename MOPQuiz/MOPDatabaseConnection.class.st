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
MOPDatabaseConnection >> createCapitalsQuiz [

	| ret newQuizId questions |
	ret := self 
		createQuizWithName: 'Capital cities' 
		withDescription: 'This will test your knowledge of capital cities!'.
	newQuizId := (ret at: (ret size)) quizId.
	
	questions := self 
		createQuestionWithText: 'What is the capital of Australia?' withType: 1 forQuiz: newQuizId;
		createQuestionWithText: 'What is the capital of Brazil?' withType: 1 forQuiz: newQuizId;
		createQuestionWithText: 'What is the capital of Belarus?' withType: 1 forQuiz: newQuizId;
		createQuestionWithText: 'What is the capital of Poland?' withType: 1 forQuiz: newQuizId;
		createQuestionWithText: 'What is the capital of Hungary?' withType: 3 forQuiz: newQuizId.
		
	self
		createAnswer: 'Sydney' isRight: false asString forQuestion: (questions at: 1) questionId;
		createAnswer: 'Canberra' isRight: true asString forQuestion: (questions at: 1) questionId;
		createAnswer: 'Melbourne' isRight: false asString forQuestion: (questions at: 1) questionId;
		createAnswer: 'Perth' isRight: false asString forQuestion: (questions at: 1) questionId;
		createAnswer: 'Sao Paolo' isRight: false asString forQuestion: (questions at: 2) questionId;
		createAnswer: 'Rio de Janeiro' isRight: false asString forQuestion: (questions at: 2) questionId;
		createAnswer: 'Brasilia' isRight: true asString forQuestion: (questions at: 2) questionId;
		createAnswer: 'Kyiv' isRight: false asString forQuestion: (questions at: 3) questionId;
		createAnswer: 'Minsk' isRight: true asString forQuestion: (questions at: 3) questionId;
		createAnswer: 'Moscow' isRight: false asString forQuestion: (questions at: 3) questionId;
		createAnswer: 'Warsaw' isRight: true asString forQuestion: (questions at: 4) questionId;
		createAnswer: 'Krakow' isRight: false asString forQuestion: (questions at: 4) questionId;
		createAnswer: 'Gdansk' isRight: false asString forQuestion: (questions at: 4) questionId;
		createAnswer: 'Debrecen' isRight: false asString forQuestion: (questions at: 5) questionId;
		createAnswer: 'Miskolc' isRight: false asString forQuestion: (questions at: 5) questionId;
		createAnswer: 'Budapest' isRight: true asString forQuestion: (questions at: 5) questionId;
		createAnswer: 'Vienna' isRight: false asString forQuestion: (questions at: 5) questionId
	
		
	 
		
]

{ #category : #initialization }
MOPDatabaseConnection >> createInternetQuiz [

	| ret newQuizId questions |
	ret := self class instance
		createQuizWithName: 'Internet'
		withDescription: 'Test your knowledge in this quiz about internet!'.
	newQuizId := (ret at: (ret size)) quizId.
	
	questions := self
		createQuestionWithText: 'What does WWW stand for?' withType: 1 forQuiz: newQuizId;
		createQuestionWithText: 'What does S in HTTPS stand for?' withType: 3 forQuiz: newQuizId;
		createQuestionWithText: 'Which of these terms are used in relation to internet?' withType: 2 forQuiz: newQuizId;
		createQuestionWithText: 'Which of the following is a valid IPv4 address?' withType: 2 forQuiz: newQuizId;
		createQuestionWithText: 'Which IPv4 address is used by a cmoputer to send a message to itself?' withType: 3 forQuiz: newQuizId;
		createQuestionWithText: 'What does URL stand for?' withType: 1 forQuiz: newQuizId.
		
	self
		createAnswer: 'World Wide West' isRight: false asString forQuestion: (questions at: 1) questionId;
		createAnswer: 'Wide Web World' isRight: false asString forQuestion: (questions at: 1) questionId;
		createAnswer: 'World Wide Web' isRight: true asString forQuestion: (questions at: 1) questionId;
		createAnswer: 'secure' isRight: true asString forQuestion: (questions at: 2) questionId;
		createAnswer: 'Secure' isRight: true asString forQuestion: (questions at: 2) questionId;
		createAnswer: 'Cookies' isRight: true asString forQuestion: (questions at: 3) questionId;
		createAnswer: 'Brownies' isRight: false asString forQuestion: (questions at: 3) questionId;
		createAnswer: 'Cake' isRight: false asString forQuestion: (questions at: 3) questionId;
		createAnswer: 'Spam' isRight: true asString forQuestion: (questions at: 3) questionId;
		createAnswer: '192.168.0.1' isRight: true asString forQuestion: (questions at: 4) questionId;
		createAnswer: '255.255.255.255' isRight: true asString forQuestion: (questions at: 4) questionId;
		createAnswer: '192.168.256.382' isRight: false asString forQuestion: (questions at: 4) questionId;
		createAnswer: '33.33.33.33' isRight: true asString forQuestion: (questions at: 4) questionId;
		createAnswer: '127.0.0.1' isRight: true asString forQuestion: (questions at: 5) questionId;
		createAnswer: 'Unique Records List' isRight: false asString forQuestion: (questions at: 6) questionId;
		createAnswer: 'Uniform Resource Locator' isRight: true asString forQuestion: (questions at: 6) questionId;
		createAnswer: 'Undefined Restricted Learner' isRight: false asString forQuestion: (questions at: 6) questionId;
		createAnswer: 'Universal Robot Location' isRight: false asString forQuestion: (questions at: 6) questionId 
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
MOPDatabaseConnection >> createSampleData [

	self 
		createCapitalsQuiz;
		createInternetQuiz
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
		session register: question. ].
	
	^ question answers
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
		| quiz |
		quiz := session readOneOf: MOPQuiz where: [ :q | q quizId = anInteger ].
		quiz questions do: [ :each | self deleteQuestionWithId: each questionId quizId: quiz quizId ].
		session delete: quiz	
	].

	^ session read: MOPQuiz
]

{ #category : #initialization }
MOPDatabaseConnection >> getAllQuizes [

	"The only way to ensure fresh data?"
	self class resetSession.
	^ ((SimpleQuery read: MOPQuiz) shouldRefresh: true) executeIn: session
]

{ #category : #initialization }
MOPDatabaseConnection >> getQuizWithId: anInteger [

	^ session readOneOf: MOPQuiz where: [ :q | q quizId = anInteger ]
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
