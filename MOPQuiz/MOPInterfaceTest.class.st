Class {
	#name : #MOPInterfaceTest,
	#superclass : #TestCase,
	#instVars : [
		'session'
	],
	#category : #'MOPQuiz-user-interface-test'
}

{ #category : #running }
MOPInterfaceTest >> setUp [

	session := MOPDatabaseConnection instance session
]

{ #category : #running }
MOPInterfaceTest >> tearDown [

	"Return the database to the original state"
	| quizes |
	quizes := session read: MOPQuiz where: [ :q | q description = 'SUnit' ].
	quizes do: [ :each | MOPDatabaseConnection instance deleteQuizWithId: each quizId ].
	super tearDown 
]
