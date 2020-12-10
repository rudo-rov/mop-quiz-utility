Class {
	#name : #MOPDatabaseConnectionTest,
	#superclass : #TestCase,
	#category : #'MOPQuiz-db'
}

{ #category : #tests }
MOPDatabaseConnectionTest >> setUp [

	MOPDatabaseConnection resetSession
]

{ #category : #tests }
MOPDatabaseConnectionTest >> tearDown [

	"Return the database to the original state"
	| session quizes |
	session := MOPDatabaseConnection instance session.
	quizes := session read: MOPQuiz where: [ :q | q description = 'SUnit' ].
	quizes do: [ :each | MOPDatabaseConnection instance deleteQuizWithId: each quizId ].
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
MOPDatabaseConnectionTest >> testCreateQuestion [
	
	| session quiz return addedQuestion |
	session := MOPDatabaseConnection instance session.
	
	"Create a quiz to register questions to"
	MOPDatabaseConnection instance
		createQuizWithName: 'SUnit_createQuestion1'
		withDescription: 'SUnit'.
		
	quiz := session readOneOf: MOPQuiz where: [ :q | q name = 'SUnit_createQuestion1' ].
	self assert: quiz isNotNil.
	self assert: quiz questions isEmpty.
	
	return := MOPDatabaseConnection instance
		createQuestionWithText: 'Test 1'
		withType: 1
		forQuiz: quiz quizId.
	self 
		assert: return isNotNil;
		assert: return class equals: OrderedCollection;
		assert: return size equals: 1.
		
	"Check if the question was registered to the correct quiz"
	quiz := MOPDatabaseConnection instance getQuizWithId: quiz quizId.
	self
		assert: quiz isNotNil;
		assert: quiz questions size equals: 1.
	addedQuestion := quiz questions at: 1.
	self 
		assert: addedQuestion text equals: 'Test 1';
		assert: addedQuestion type equals: 1;
		assert: addedQuestion questionId isNotNil.
		
	"Add another question, now only check for increased size"
	MOPDatabaseConnection instance
		createQuestionWithText: 'Test 2' 
		withType: 2 
		forQuiz: quiz quizId.
	quiz := MOPDatabaseConnection instance getQuizWithId: quiz quizId.
	self 
		assert: quiz questions size equals: 2	
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
