Class {
	#name : #MOPQuizDetails,
	#superclass : #ComposableModel,
	#instVars : [
		'quiz',
		'labelName',
		'labelDescription',
		'textName',
		'textDescription'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #specs }
MOPQuizDetails class >> defaultSpec [

	^ SpecColumnLayout composed
		newRow: [ :row |
			row add: #labelName; add: #textName ] height: ComposableModel buttonHeight;
		newRow: [ :row |
			row add: #labelDescription; add: #textDescription ] height: ComposableModel buttonHeight;
		yourself
]

{ #category : #initialization }
MOPQuizDetails >> initializeWidgets [
	
	labelName := self newLabel
		label: 'Name'.
	labelDescription := self newLabel
		label: 'Description'.
		
	textName := self newTextInput.
	textDescription := self newTextInput.
	
	self focusOrder
		add: textName;
		add: textDescription
]

{ #category : #accessing }
MOPQuizDetails >> labelDescription [
	^ labelDescription
]

{ #category : #accessing }
MOPQuizDetails >> labelDescription: anObject [
	labelDescription := anObject
]

{ #category : #accessing }
MOPQuizDetails >> labelName [
	^ labelName
]

{ #category : #accessing }
MOPQuizDetails >> labelName: anObject [
	labelName := anObject
]

{ #category : #accessing }
MOPQuizDetails >> quiz [
	^ quiz
]

{ #category : #accessing }
MOPQuizDetails >> quiz: anObject [
	
	quiz := anObject.
	textName text: quiz name.
	textDescription text: quiz description
]

{ #category : #accessing }
MOPQuizDetails >> textDescription [
	^ textDescription
]

{ #category : #accessing }
MOPQuizDetails >> textDescription: anObject [
	textDescription := anObject
]

{ #category : #accessing }
MOPQuizDetails >> textName [
	^ textName
]

{ #category : #accessing }
MOPQuizDetails >> textName: anObject [
	textName := anObject
]
