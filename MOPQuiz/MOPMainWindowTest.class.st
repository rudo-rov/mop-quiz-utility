Class {
	#name : #MOPMainWindowTest,
	#superclass : #MOPInterfaceTest,
	#category : #'MOPQuiz-user-interface-test'
}

{ #category : #running }
MOPMainWindowTest >> setUp [

	super setUp
]

{ #category : #running }
MOPMainWindowTest >> tearDown [ 

	super tearDown
]

{ #category : #running }
MOPMainWindowTest >> testQuizDeletion [

	| window quizes |
	MOPDatabaseConnection instance
		createQuizWithName: 'SUnit_quizDeletion1'
		withDescription: 'SUnit'.
		
	window := MOPMainWindow new.
	window buildWithSpec.
	window listQuiz setSelectedIndex: (window listQuiz listItems size).
	window buttonDelete performAction.
	
	quizes := MOPDatabaseConnection instance getAllQuizes.
	self assert: quizes size equals: window listQuiz listItems size.
	1 to: quizes size do: [ :cnt |
		self assert: ((quizes at: cnt) isTheSameAs: (window listQuiz listItems at: cnt)) ]
	
	
	
]

{ #category : #running }
MOPMainWindowTest >> testWindowInitialization [

	| window quizes |
	window := MOPMainWindow new.
	window buildWithSpec.
	quizes := MOPDatabaseConnection instance getAllQuizes.
	
	self assert: window listQuiz listItems size equals: quizes size.
	
	1 to: quizes size do: [ :cnt |
		self assert: ((window listQuiz listItems at: cnt) isTheSameAs: (quizes at: cnt)) ]
]
