Class {
	#name : #MOPQuizModify,
	#superclass : #ComposableModel,
	#instVars : [
		'quiz',
		'labelName',
		'labelDescription',
		'textName',
		'textDescription',
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
			row add: #labelName; add: #textName ] height: ComposableModel buttonHeight;
		newRow: [ :row |
			row add: #labelDescription; add: #textDescription ] height: ComposableModel buttonHeight;
		newRow: [ :row |
			row 
				newColumn: [ :col | col add: #listQuestions ];
				newColumn: [ :col | col add: #listAnswers ] 
		];
		newRow: [ :row |
			row add: #buttonSave ] height: ComposableModel buttonHeight 
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
	
	labelName := self newLabel
		label: 'Name'.
	textName := self newTextInput.
	labelDescription := self newLabel
		label: 'Description'.
	textDescription := self newTextInput.
	
	buttonSave := self newButton
		label: 'Save';
		icon: (self iconNamed: #smallSave).
		
	listQuestions := self newList.
	
	listAnswers := self newList.
]

{ #category : #accessing }
MOPQuizModify >> labelDescription [
	^ labelDescription
]

{ #category : #accessing }
MOPQuizModify >> labelDescription: anObject [
	labelDescription := anObject
]

{ #category : #accessing }
MOPQuizModify >> labelName [
	^ labelName
]

{ #category : #accessing }
MOPQuizModify >> labelName: anObject [
	labelName := anObject
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

{ #category : #initialization }
MOPQuizModify >> setQuiz: aMOPQuiz [

	quiz := aMOPQuiz.
	textName text: quiz name.
	textDescription text: quiz description
	
	"TODO: Set questions"
]

{ #category : #accessing }
MOPQuizModify >> textDescription [
	^ textDescription
]

{ #category : #accessing }
MOPQuizModify >> textDescription: anObject [
	textDescription := anObject
]

{ #category : #accessing }
MOPQuizModify >> textName [
	^ textName
]

{ #category : #accessing }
MOPQuizModify >> textName: anObject [
	textName := anObject
]

{ #category : #api }
MOPQuizModify >> title [

	^ 'Modify quiz'
]
