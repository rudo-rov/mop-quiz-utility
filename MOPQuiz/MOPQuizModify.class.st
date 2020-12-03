Class {
	#name : #MOPQuizModify,
	#superclass : #ComposableModel,
	#instVars : [
		'quiz',
		'quizDetails',
		'listQuestions',
		'listAnswers',
		'buttonSave',
		'buttonDeleteQuestion',
		'buttonAddQuestion'
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
				newColumn: [ :col | 
					col 
						add: #listQuestions;
						newRow: [ :inRow |
							inRow add: #buttonAddQuestion; add: #buttonDeleteQuestion  ] height: ComposableModel buttonHeight ];
				newColumn: [ :col | col add: #listAnswers ] 
		];
		newRow: [ :row |
			row add: #buttonSave ] height: ComposableModel buttonHeight;
		yourself
]

{ #category : #accessing }
MOPQuizModify >> buttonAddQuestion [
	^ buttonAddQuestion
]

{ #category : #accessing }
MOPQuizModify >> buttonAddQuestion: anObject [
	buttonAddQuestion := anObject
]

{ #category : #accessing }
MOPQuizModify >> buttonDeleteQuestion [
	^ buttonDeleteQuestion
]

{ #category : #accessing }
MOPQuizModify >> buttonDeleteQuestion: anObject [
	buttonDeleteQuestion := anObject
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
MOPQuizModify >> initializePresenter [

	buttonDeleteQuestion action: [ self onDeleteQuestionClick  ].
	buttonAddQuestion action: [ 
		| createWindow |
		createWindow := MOPQuestionCreate new.
		createWindow quiz: quiz.
		"createWindow openWithSpec modalRelativeTo: World"
		createWindow openWithSpec ].
	listQuestions whenSelectedItemChanged: [ self onSelectedQuestionChanged ]
	
]

{ #category : #initialization }
MOPQuizModify >> initializeWidgets [
	
	quizDetails := self instantiate: MOPQuizDetails.
	
	buttonSave := self newButton
		label: 'Save';
		icon: (self iconNamed: #smallSave).
		
	buttonDeleteQuestion := self newButton
		label: 'Delete';
		icon: (self iconNamed: #changeRemove).
		
	buttonAddQuestion := self newButton
		label: 'Add';
		icon: (self iconNamed: #add).
		
	listQuestions := self newList.
	
	"Items for this list in initializePresenter"
	listAnswers := self newList.
	
	self focusOrder
		add: quizDetails;
		add: listQuestions;
		add: listAnswers;
		add: buttonAddQuestion;
		add: buttonDeleteQuestion;
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
MOPQuizModify >> onDeleteQuestionClick [

	| pickedQuestion newQuestionList |
	pickedQuestion := listQuestions selectedItem.
	
	newQuestionList := MOPApiRequests new 
		deleteQuestionWithId: pickedQuestion questionId quiz: quiz quizId.
		
	listQuestions items: newQuestionList
]

{ #category : #accessing }
MOPQuizModify >> onSelectedQuestionChanged [

	| selectedQuestion |
	selectedQuestion := listQuestions selectedItem.
	selectedQuestion ifNotNil: [ 
		listAnswers
			items: selectedQuestion answers;
			displayBlock: [ :a | a text ];
			sortingBlock: [ :a1 :a2 | a1 answerId < a2 answerId ] ]
	
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
		displayBlock: [ :q | q text ];
		sortingBlock: [ :qA :qB | qA questionId < qB questionId ]
]

{ #category : #api }
MOPQuizModify >> title [

	^ 'Modify quiz'
]
