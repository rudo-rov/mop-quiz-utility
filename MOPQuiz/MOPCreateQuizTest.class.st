Class {
	#name : #MOPCreateQuizTest,
	#superclass : #MOPInterfaceTest,
	#category : #'MOPQuiz-user-interface-test'
}

{ #category : #running }
MOPCreateQuizTest >> setUp [

	super setUp
]

{ #category : #running }
MOPCreateQuizTest >> tearDown [

	super tearDown
]

{ #category : #running }
MOPCreateQuizTest >> testQuizCreate [

	| mainWindow window before after |
	mainWindow := MOPMainWindow new.
	mainWindow buildWithSpec.
	before := MOPDatabaseConnection instance getAllQuizes.
	after := before.
	window := MOPQuizCreate new.
	window openWithSpec.
	window quizDetails textName text: 'SUnit_testCreateQuiz1'.
	window quizDetails textDescription text: 'SUnit'.
	window quizes: mainWindow listQuiz.
	window buttonSave performAction.
	
	self assert: before size equals: after size
]
