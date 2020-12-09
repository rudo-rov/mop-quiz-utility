Class {
	#name : #MOPDatabaseConnectionTest,
	#superclass : #TestCase,
	#category : #'MOPQuiz-db'
}

{ #category : #tests }
MOPDatabaseConnectionTest >> tearDown [

	"Return the database to the original state"
	| session |
	session := MOPDatabaseConnection instance session.
	session inUnitOfWorkDo: [ 
		session 
			delete: MOPQuiz
			where: [ :quiz | quiz description = 'SUnit' ] ].
	super tearDown 
]

{ #category : #tests }
MOPDatabaseConnectionTest >> testConnectionToDb [

	| instance |
	instance := MOPDatabaseConnection instance.
	self assert: instance isNotNil.
	self assert: instance session accessor isLoggedIn
]

{ #category : #tests }
MOPDatabaseConnectionTest >> testCreateQuiz [

	| session origin ret1 createdEntity |
	session := MOPDatabaseConnection instance session.
	origin := MOPDatabaseConnection instance getAllQuizes.
	
	"Create a simple quiz"
	ret1 := MOPDatabaseConnection instance
		createQuizWithName: 'SUnit_createQuiz1'
		withDescription: 'SUnit'.
	
	self assert: ret1 class equals: Array.
	self assert: ret1 size equals: origin size + 1.
	
	createdEntity := session readOneOf: MOPQuiz where: [ :quiz | quiz name = 'SUnit_createQuiz1' ].
	self assert: createdEntity isNotNil.
	self assert: createdEntity name equals: 'SUnit_createQuiz1'.
	self assert: createdEntity description equals: 'SUnit'.
	self assert: createdEntity questions isEmpty.
]
