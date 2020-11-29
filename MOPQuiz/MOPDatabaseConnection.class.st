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
MOPDatabaseConnection >> getAllQuizes [

	^ ((SimpleQuery read: MOPQuiz)
		orderBy: [ :each | each quizId descending ]
	)
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
