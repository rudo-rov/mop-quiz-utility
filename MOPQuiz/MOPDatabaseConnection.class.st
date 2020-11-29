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
MOPDatabaseConnection >> getAllQuizes [

	^ session read: MOPQuiz
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
