Class {
	#name : #MOPQuestionCreate,
	#superclass : #ComposableModel,
	#instVars : [
		'quiz',
		'labelType',
		'radioTypeGroup',
		'labelText',
		'textQuestion',
		'buttonSave',
		'radioSingle',
		'radioMulti',
		'radioText',
		'newQuestionType',
		'listQuestions'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #specs }
MOPQuestionCreate class >> defaultSpec [

	^ SpecColumnLayout composed
		newRow: [ :row |
			row add: #labelText; add: #textQuestion ] height: ComposableModel buttonHeight;
		newRow: [ :row |
			row add: #labelType; add: #radioSingle; add: #radioMulti; add: #radioText ] height: ComposableModel buttonHeight;
		newRow: [ :row |
			row add: #buttonSave ] height: ComposableModel buttonHeight;
		yourself
]

{ #category : #accessing }
MOPQuestionCreate >> buttonSave [
	^ buttonSave
]

{ #category : #accessing }
MOPQuestionCreate >> buttonSave: anObject [
	buttonSave := anObject
]

{ #category : #initialization }
MOPQuestionCreate >> initializePresenter [

	radioSingle activationAction: [ newQuestionType = 1 ].
	radioMulti activationAction: [ newQuestionType = 2 ].
	radioText activationAction: [ newQuestionType = 3 ].
	buttonSave action: [ self onSaveClick  ]
]

{ #category : #initialization }
MOPQuestionCreate >> initializeWidgets [
	
	labelText := self newLabel
		label: 'Question'.
	labelType := self newLabel
		label: 'Type'.
	textQuestion := self newTextInput
		autoAccept: true.
	buttonSave := self newButton
		label: 'Save';
		icon: (self iconNamed: #smallSave).
		
	radioTypeGroup := RadioButtonGroup new.
	radioSingle := self newRadioButton
		label: 'Single-choice';
		canDeselectByClick: false.
	radioTypeGroup addRadioButton: radioSingle; default: radioSingle.
	radioMulti := self newRadioButton
		label: 'Multi-choice';
		canDeselectByClick: false.
	radioTypeGroup addRadioButton: radioMulti.
	radioText := self newRadioButton
		label: 'Textual';
		canDeselectByClick: false.
	radioTypeGroup addRadioButton: radioText.
	
		
	
]

{ #category : #accessing }
MOPQuestionCreate >> labelText [
	^ labelText
]

{ #category : #accessing }
MOPQuestionCreate >> labelText: anObject [
	labelText := anObject
]

{ #category : #accessing }
MOPQuestionCreate >> labelType [
	^ labelType
]

{ #category : #accessing }
MOPQuestionCreate >> labelType: anObject [
	labelType := anObject
]

{ #category : #initialization }
MOPQuestionCreate >> listQuestions: aList [

	listQuestions := aList
]

{ #category : #initialization }
MOPQuestionCreate >> onSaveClick [

	| text newList |
	text := textQuestion text.
	text ifNotNil: [ 
		newList := MOPApiRequests new
			createQuestionWithText: text 
			withType: newQuestionType  
			forQuiz: quiz quizId ].
	quiz questions: newList.
	listQuestions items: newList.
	self window close
]

{ #category : #accessing }
MOPQuestionCreate >> quiz [
	^ quiz
]

{ #category : #accessing }
MOPQuestionCreate >> quiz: anObject [
	quiz := anObject
]

{ #category : #accessing }
MOPQuestionCreate >> radioMulti [
	^ radioMulti
]

{ #category : #accessing }
MOPQuestionCreate >> radioMulti: anObject [
	radioMulti := anObject
]

{ #category : #accessing }
MOPQuestionCreate >> radioSingle [
	^ radioSingle
]

{ #category : #accessing }
MOPQuestionCreate >> radioSingle: anObject [
	radioSingle := anObject
]

{ #category : #accessing }
MOPQuestionCreate >> radioText [
	^ radioText
]

{ #category : #accessing }
MOPQuestionCreate >> radioText: anObject [
	radioText := anObject
]

{ #category : #accessing }
MOPQuestionCreate >> radioTypeGroup [
	^ radioTypeGroup
]

{ #category : #accessing }
MOPQuestionCreate >> radioTypeGroup: anObject [
	radioTypeGroup := anObject
]

{ #category : #accessing }
MOPQuestionCreate >> textQuestion [
	^ textQuestion
]

{ #category : #accessing }
MOPQuestionCreate >> textQuestion: anObject [
	textQuestion := anObject
]

{ #category : #initialization }
MOPQuestionCreate >> title [ 
	
	^ 'Create a question'
]
