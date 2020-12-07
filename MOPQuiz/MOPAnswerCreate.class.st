Class {
	#name : #MOPAnswerCreate,
	#superclass : #ComposableModel,
	#instVars : [
		'question',
		'labelText',
		'textQuestion',
		'radioGroup',
		'radioIsRight',
		'radioIsFalse',
		'buttonSave',
		'isRight'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #specs }
MOPAnswerCreate class >> defaultSpec [

	^ SpecColumnLayout composed
		newRow: [ :row |
			row add: #labelText; add: #textQuestion ] height: ComposableModel buttonHeight;
		newRow: [ :row |
			row add: #radioIsRight; add: #radioIsFalse ] height: ComposableModel buttonHeight;
		newRow: [ :row |
			row add: #buttonSave ] height: ComposableModel buttonHeight;
		yourself
]

{ #category : #accessing }
MOPAnswerCreate >> buttonSave [
	^ buttonSave
]

{ #category : #accessing }
MOPAnswerCreate >> buttonSave: anObject [
	buttonSave := anObject
]

{ #category : #accessing }
MOPAnswerCreate >> initializePresenter [

	radioIsRight activationAction: [ isRight := true ].
	radioIsFalse activationAction: [ isRight := false ].
	buttonSave action: [ self onSaveClick ]
]

{ #category : #accessing }
MOPAnswerCreate >> initializeWidgets [

	labelText := self newLabel
		label: 'Answer'.
	textQuestion := self newTextInput
		autoAccept: true.
	buttonSave := self newButton
		label: 'Save';
		icon: (self iconNamed: #smallSave).
	
	radioGroup := RadioButtonGroup new.
	radioIsRight := self newRadioButton
		label: 'Right';
		canDeselectByClick: false.
	radioGroup addRadioButton: radioIsRight; default: radioIsRight.
	radioIsFalse := self newRadioButton
		label: 'Wrong';
		canDeselectByClick: false.
	radioGroup addRadioButton: radioIsFalse.
	
	self focusOrder
		add: textQuestion;
		add: radioIsRight;
		add: radioIsFalse;
		add: buttonSave
]

{ #category : #accessing }
MOPAnswerCreate >> labelText [
	^ labelText
]

{ #category : #accessing }
MOPAnswerCreate >> labelText: anObject [
	labelText := anObject
]

{ #category : #accessing }
MOPAnswerCreate >> onSaveClick [
	
	| newAnswerText |
	newAnswerText := textQuestion text.
	newAnswerText ifNotEmpty: [ 
		| response |
		response := MOPApiRequests new
			createAnswer: newAnswerText
			isRight: isRight
			forQuestion: question questionId.
		question answers: response.
		self window close ]
	"TODO: use response as a new "
]

{ #category : #accessing }
MOPAnswerCreate >> question [
	^ question
]

{ #category : #accessing }
MOPAnswerCreate >> question: anObject [
	question := anObject
]

{ #category : #accessing }
MOPAnswerCreate >> radioGroup [
	^ radioGroup
]

{ #category : #accessing }
MOPAnswerCreate >> radioGroup: anObject [
	radioGroup := anObject
]

{ #category : #accessing }
MOPAnswerCreate >> radioIsFalse [
	^ radioIsFalse
]

{ #category : #accessing }
MOPAnswerCreate >> radioIsFalse: anObject [
	radioIsFalse := anObject
]

{ #category : #accessing }
MOPAnswerCreate >> radioIsRight [
	^ radioIsRight
]

{ #category : #accessing }
MOPAnswerCreate >> radioIsRight: anObject [
	radioIsRight := anObject
]

{ #category : #accessing }
MOPAnswerCreate >> textQuestion [
	^ textQuestion
]

{ #category : #accessing }
MOPAnswerCreate >> textQuestion: anObject [
	textQuestion := anObject
]

{ #category : #accessing }
MOPAnswerCreate >> title [ 

	^ 'Add answer'
]
