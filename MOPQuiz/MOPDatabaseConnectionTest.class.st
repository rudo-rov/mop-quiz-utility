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

{ #category : #tests }
MOPDatabaseConnectionTest >> testDeleteQuestion [

	| session quiz ret1 ret2 question1 question2 |
	session := MOPDatabaseConnection instance session.
	MOPDatabaseConnection instance
		createQuizWithName: 'SUnit_deleteQuestion1'
		withDescription: 'SUnit'.
	quiz := session readOneOf: MOPQuiz where: [ :q | q name = 'SUnit_deleteQuestion1' ].
	self 
		assert: quiz isNotNil;
		assert: quiz questions isEmpty.
		
	MOPDatabaseConnection instance
		createQuestionWithText: 'SUnit_deleteQuestion1' withType: 1 forQuiz: quiz quizId;
		createQuestionWithText: 'SUnit_deleteQuestion2' withType: 1 forQuiz: quiz quizId.
		
	quiz := MOPDatabaseConnection instance getQuizWithId: quiz quizId.
	self 
		assert: quiz questions size equals: 2.
	question1 := quiz questions at: 1.
	question2 := quiz questions at: 2.
	
	ret1 := MOPDatabaseConnection instance deleteQuestionWithId: question1 questionId quizId: quiz quizId.
	self
		assert: ret1 isNotNil;
		assert: ret1 class equals: OrderedCollection;
		assert: ret1 size equals: 1.
	quiz := MOPDatabaseConnection instance getQuizWithId: quiz quizId.
	self
		assert: quiz questions size equals: 1.
		
	ret2 := MOPDatabaseConnection	instance deleteQuestionWithId: question1 questionId quizId: quiz quizId.
	self
		assert: ret2 isNotNil;
		assert: ret2 class equals: OrderedCollection;
		assert: ret2 size equals: 1.
	quiz := MOPDatabaseConnection instance getQuizWithId: quiz quizId.
	self
		assert: quiz questions size equals: 1.
		
	ret2 := MOPDatabaseConnection instance deleteQuestionWithId: question2 questionId quizId: quiz quizId.
	self
		assert: ret2 isNotNil;
		assert: ret2 class equals: OrderedCollection;
		assert: ret2 size equals: 0.
	quiz := MOPDatabaseConnection instance getQuizWithId: quiz quizId.
	self
		assert: quiz questions isEmpty.
]

{ #category : #tests }
MOPDatabaseConnectionTest >> testDeleteQuiz [

	| emptyQuiz filledQuiz session ret1 ret2 |
	session := MOPDatabaseConnection instance session.
	
	MOPDatabaseConnection instance
		createQuizWithName: 'Empty quiz' 
		withDescription: 'SUnit'.
	emptyQuiz := session readOneOf: MOPQuiz where: [ :q | q name = 'Empty quiz' ].
	self assert: emptyQuiz isNotNil.
	
	MOPDatabaseConnection instance
		createQuizWithName: 'Filled quiz'
		withDescription: 'SUnit'.
	filledQuiz := session readOneOf: MOPQuiz where: [ :q | q name = 'Filled quiz' ].
	self assert: filledQuiz isNotNil.
	MOPDatabaseConnection instance
		createQuestionWithText: 'Test 1' withType: 1 forQuiz: filledQuiz quizId;
		createQuestionWithText: 'Test 2' withType: 2 forQuiz: filledQuiz quizId;
		createQuestionWithText: 'Test 3' withType: 3 forQuiz: filledQuiz quizId.
		
	ret1 := MOPDatabaseConnection instance
		deleteQuizWithId: emptyQuiz quizId.
	self 
		assert: ret1 isNotNil;
		assert: ret1 class equals: Array;
		assert: (session readOneOf: MOPQuiz where: [ :q | q quizId = emptyQuiz quizId ]) isNil.
		
	ret2 := MOPDatabaseConnection instance
		deleteQuizWithId: filledQuiz quizId.
	self
		assert: ret2 isNotNil;
		assert: ret2 class equals: Array;
		assert: (session readOneOf: MOPQuiz where: [ :q | q quizId = filledQuiz quizId ]) isNil
		
		
]
