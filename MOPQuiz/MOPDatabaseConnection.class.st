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
	
	session inUnitOfWorkDo: [ session register: newInstance ]
]

{ #category : #initialization }
MOPDatabaseConnection >> deleteAnswerWithId: anInteger [

	session inUnitOfWorkDo: [ 
		session delete: MOPAnswer where: [ :each | each answerId = anInteger ]	
	]
]

{ #category : #initialization }
MOPDatabaseConnection >> deleteQuestionWithId: anInteger [

	session inUnitOfWorkDo: [ 
		session delete: MOPQuestion where: [ :each | each questionId = anInteger ]	
	]
]

{ #category : #initialization }
MOPDatabaseConnection >> deleteQuizWithId: anInteger [

	session inUnitOfWorkDo: [ 
		session delete: MOPQuiz where: [ :each | each quizId = anInteger ]	
	]
]

{ #category : #initialization }
MOPDatabaseConnection >> getAllQuizes [

	^ session read: MOPQuiz
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
MOPDatabaseConnection >> session [

	^ session
]
