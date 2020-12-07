Class {
	#name : #MOPQuizWindow,
	#superclass : #ComposableModel,
	#instVars : [
		'quizProgress',
		'buttonNext',
		'buttonSkip',
		'questionWidget'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #specs }
MOPQuizWindow class >> defaultSpec [

	^ SpecColumnLayout composed
		newRow: [ :row |
			row add: #questionWidget ];
		newRow: [ :row |
			row add: #buttonSkip; add: #buttonNext ] height: ComposableModel buttonHeight;
		yourself
]

{ #category : #accessing }
MOPQuizWindow >> buttonNext [
	^ buttonNext
]

{ #category : #accessing }
MOPQuizWindow >> buttonNext: anObject [
	buttonNext := anObject
]

{ #category : #accessing }
MOPQuizWindow >> buttonSkip [
	^ buttonSkip
]

{ #category : #accessing }
MOPQuizWindow >> buttonSkip: anObject [
	buttonSkip := anObject
]

{ #category : #initialization }
MOPQuizWindow >> initializeWidgets [
	
	buttonNext := self newButton
		label: 'Next';
		icon: (self iconNamed: #glamorousAccept).
	buttonSkip := self newButton
		label: 'Skip';
		icon: (self iconNamed: #forward).
		
	questionWidget := self instantiate: MOPInitialWidget.
		
	self focusOrder
		add: buttonSkip;
		add: buttonNext
]

{ #category : #accessing }
MOPQuizWindow >> questionWidget [
	^ questionWidget
]

{ #category : #accessing }
MOPQuizWindow >> questionWidget: anObject [
	questionWidget := anObject
]

{ #category : #accessing }
MOPQuizWindow >> quizProgress [
	^ quizProgress
]

{ #category : #accessing }
MOPQuizWindow >> quizProgress: anObject [
	
	quizProgress := anObject.
	questionWidget setDescription: quizProgress quiz description
]

{ #category : #initialization }
MOPQuizWindow >> title [

	| quiz |
	quiz := quizProgress quiz.
	quiz
		ifNil: [ ^ 'Quiz' ]
		ifNotNil: [ ^ quiz name ]
]
