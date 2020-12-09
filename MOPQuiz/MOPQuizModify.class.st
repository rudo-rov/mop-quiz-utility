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
		'buttonAddQuestion',
		'buttonDeleteAnswer',
		'buttonAddAnswer'
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
				newColumn: [ :col | 
					col 
						add: #listAnswers;
						newRow: [ :inRow |
							inRow add: #buttonAddAnswer; add: #buttonDeleteAnswer ] height: ComposableModel buttonHeight ] 
		];
		newRow: [ :row |
			row add: #buttonSave ] height: ComposableModel buttonHeight;
		yourself
]

{ #category : #accessing }
MOPQuizModify >> buttonAddAnswer [
	^ buttonAddAnswer
]

{ #category : #accessing }
MOPQuizModify >> buttonAddAnswer: anObject [
	buttonAddAnswer := anObject
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
MOPQuizModify >> buttonDeleteAnswer [
	^ buttonDeleteAnswer
]

{ #category : #accessing }
MOPQuizModify >> buttonDeleteAnswer: anObject [
	buttonDeleteAnswer := anObject
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
MOPQuizModify >> extent [

	^ 600@500
]

{ #category : #initialization }
MOPQuizModify >> initializePresenter [

	buttonDeleteQuestion action: [ self onDeleteQuestionClick  ].
	buttonDeleteAnswer action: [ self onDeleteAnswerClick ].
	buttonAddQuestion action: [ 
		| createWindow |
		createWindow := MOPQuestionCreate new.
		createWindow quiz: quiz;
			listQuestions: listQuestions.
		createWindow openWithSpec modalRelativeTo: self ].
	buttonAddAnswer action: [ 
		| createWindow selectedQuestion |
		createWindow := MOPAnswerCreate new.
		selectedQuestion := listQuestions selectedItem.
		createWindow question: selectedQuestion;
			listAnswers: listAnswers.
		createWindow openWithSpec modalRelativeTo: self ].
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
		
	buttonAddAnswer := self newButton
		label: 'Add';
		icon: (self iconNamed: #add).
		
	buttonDeleteAnswer := self newButton
		label: 'Delete';
		icon: (self iconNamed: #changeRemove).
		
	listQuestions := self newList.
	
	"Items for this list in initializePresenter"
	listAnswers := self newList.
	
	self focusOrder
		add: quizDetails;
		add: listQuestions;
		add: listAnswers;
		add: buttonAddQuestion;
		add: buttonDeleteQuestion;
		add: buttonAddAnswer;
		add: buttonDeleteAnswer;
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
MOPQuizModify >> onDeleteAnswerClick [

	| newAnswersList pickedQuestion |
	pickedQuestion := listQuestions selectedItem.
	pickedQuestion ifNotNil: [ 
		| pickedAnswer |
		pickedAnswer := listAnswers selectedItem.
		pickedAnswer ifNotNil: [ 
			newAnswersList := MOPApiRequests new
				deleteAnswerWithId: pickedAnswer answerId
				forQuestion: pickedQuestion questionId.
			listAnswers items: newAnswersList.
			pickedQuestion answers: newAnswersList. ] ]
]

{ #category : #accessing }
MOPQuizModify >> onDeleteQuestionClick [

	| pickedQuestion newQuestionList |
	pickedQuestion := listQuestions selectedItem.
	
	newQuestionList := MOPApiRequests new 
		deleteQuestionWithId: pickedQuestion questionId quiz: quiz quizId.
		
	quiz questions: newQuestionList.
	listQuestions items: newQuestionList
]

{ #category : #accessing }
MOPQuizModify >> onSelectedQuestionChanged [

	| selectedQuestion |
	selectedQuestion := listQuestions selectedItem.
	selectedQuestion ifNotNil: [ 
		listAnswers
			items: (selectedQuestion answers
				ifNotNil: [ selectedQuestion answers ]
				ifNil: [ OrderedCollection new ]);
			displayBlock: [ :a | a text ];
			sortingBlock: [ :a1 :a2 | a1 answerId < a2 answerId ];
			icons: [ :a | a isRight
				ifTrue: [ (self iconNamed: #glamorousAccept ) ]
				ifFalse: [ (self iconNamed: #glamorousRedCircle) ] ] ]  
	
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
