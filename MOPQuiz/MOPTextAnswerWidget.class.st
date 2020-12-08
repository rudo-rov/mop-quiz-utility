Class {
	#name : #MOPTextAnswerWidget,
	#superclass : #ComposableModel,
	#instVars : [
		'question',
		'labelQuestion',
		'textAnswer'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #specs }
MOPTextAnswerWidget class >> defaultSpec [

	^ SpecColumnLayout composed
		newRow: [ :row |
			row add: #labelQuestion ] height: ComposableModel buttonHeight;
		newRow: [ :row |
			row add: #textAnswer ] height: ComposableModel buttonHeight;
		yourself
]

{ #category : #'instance creation' }
MOPTextAnswerWidget class >> on: aQuestion [

	| inst |
	inst := self basicNew.
	inst question: aQuestion.
	inst initialize.
	^ inst
]

{ #category : #initialization }
MOPTextAnswerWidget >> evaluateAnswer [

	| currentAnswer |
	currentAnswer := textAnswer text.
	(question answers anySatisfy: [ :answer | answer text = currentAnswer ])
		ifTrue: [ ^ 1 ]
		ifFalse: [ ^ 0 ]
]

{ #category : #initialization }
MOPTextAnswerWidget >> initializeWidgets [
	
	labelQuestion := self newLabel
		label: question text.
		
	textAnswer := self newTextInput
		autoAccept: true.
		
	self focusOrder
		add: textAnswer.
]

{ #category : #accessing }
MOPTextAnswerWidget >> labelQuestion [
	^ labelQuestion
]

{ #category : #accessing }
MOPTextAnswerWidget >> labelQuestion: anObject [
	labelQuestion := anObject
]

{ #category : #accessing }
MOPTextAnswerWidget >> question: anObject [
	question := anObject
]

{ #category : #accessing }
MOPTextAnswerWidget >> textAnswer [
	^ textAnswer
]

{ #category : #accessing }
MOPTextAnswerWidget >> textAnswer: anObject [
	textAnswer := anObject
]
