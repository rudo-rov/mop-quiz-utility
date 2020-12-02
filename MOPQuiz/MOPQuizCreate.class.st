Class {
	#name : #MOPQuizCreate,
	#superclass : #ComposableModel,
	#instVars : [
		'quizDetails',
		'buttonSave',
		'quizes'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #specs }
MOPQuizCreate class >> defaultSpec [

	^ SpecColumnLayout composed
		newRow: [ :row |
			row add: #quizDetails ] height: 2 * ComposableModel buttonHeight;
		newRow: [ :row |
			row add: #buttonSave ] height: ComposableModel buttonHeight;
		yourself
]

{ #category : #accessing }
MOPQuizCreate >> buttonSave [
	^ buttonSave
]

{ #category : #accessing }
MOPQuizCreate >> buttonSave: anObject [
	buttonSave := anObject
]

{ #category : #initialization }
MOPQuizCreate >> initializePresenter [

	buttonSave action: [ self onSaveClick ]
]

{ #category : #initialization }
MOPQuizCreate >> initializeWidgets [
	
	quizDetails := self instantiate: MOPQuizDetails.
	
	buttonSave := self newButton
		label: 'Save';
		icon: (self iconNamed: #smallSave).
		
	self focusOrder 
		add: quizDetails;
		add: buttonSave
]

{ #category : #initialization }
MOPQuizCreate >> onSaveClick [

	"TODO: Add a control for empty name"
	| inName inDesc |
	inName := quizDetails textName text.
	inDesc := quizDetails textDescription text.
	
	inName ifNotEmpty: [ 
		quizes items: (MOPApiRequests new createQuizWithName: inName withDescription: inDesc).
		self window close ]
	
]

{ #category : #accessing }
MOPQuizCreate >> quizDetails [
	^ quizDetails
]

{ #category : #accessing }
MOPQuizCreate >> quizDetails: anObject [
	quizDetails := anObject
]

{ #category : #initialization }
MOPQuizCreate >> quizes: aCollection [

	quizes := aCollection
]

{ #category : #initialization }
MOPQuizCreate >> title [
	
	^ 'Create a quiz'
]
