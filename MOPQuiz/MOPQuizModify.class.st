Class {
	#name : #MOPQuizModify,
	#superclass : #ComposableModel,
	#instVars : [
		'quiz',
		'quizDetails',
		'listQuestions',
		'listAnswers',
		'buttonSave'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #specs }
MOPQuizModify class >> defaultSpec [

	^ SpecColumnLayout composed
		newRow: [ :row |
			row add: #quizDetails ] height: 2 * ComposableModel buttonHeight;
		newRow: [ :row |
			row 
				newColumn: [ :col | col add: #listQuestions ];
				newColumn: [ :col | col add: #listAnswers ] 
		];
		newRow: [ :row |
			row add: #buttonSave ] height: ComposableModel buttonHeight;
		yourself
]

{ #category : #accessing }
MOPQuizModify >> buttonSave [
	^ buttonSave
]

{ #category : #accessing }
MOPQuizModify >> buttonSave: anObject [
	buttonSave := anObject
]

{ #category : #initialization }
MOPQuizModify >> initializeWidgets [
	
	quizDetails := self instantiate: MOPQuizDetails.
	
	buttonSave := self newButton
		label: 'Save';
		icon: (self iconNamed: #smallSave).
		
	listQuestions := self newList.
	
	"Items for this list in initializePresenter"
	listAnswers := self newList.
	
	self focusOrder
		add: quizDetails;
		add: listQuestions;
		add: listAnswers;
		add: buttonSave
]

{ #category : #accessing }
MOPQuizModify >> listAnswers [
	^ listAnswers
]

{ #category : #accessing }
MOPQuizModify >> listAnswers: anObject [
	listAnswers := anObject
]

{ #category : #accessing }
MOPQuizModify >> listQuestions [
	^ listQuestions
]

{ #category : #accessing }
MOPQuizModify >> listQuestions: anObject [
	listQuestions := anObject
]

{ #category : #accessing }
MOPQuizModify >> quiz [
	^ quiz
]

{ #category : #accessing }
MOPQuizModify >> quiz: anObject [
	quiz := anObject
]

{ #category : #accessing }
MOPQuizModify >> quizDetails [
	^ quizDetails
]

{ #category : #accessing }
MOPQuizModify >> quizDetails: anObject [
	quizDetails := anObject
]

{ #category : #initialization }
MOPQuizModify >> setQuiz: aMOPQuiz [

	quiz := aMOPQuiz.
	quizDetails quiz: quiz.
	
	"TODO: Set questions"
	listQuestions
		items: quiz questions;
		displayBlock: [ :q | q text ]
]

{ #category : #api }
MOPQuizModify >> title [

	^ 'Modify quiz'
]
