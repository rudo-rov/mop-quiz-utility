Class {
	#name : #MOPQuizWindow,
	#superclass : #ComposableModel,
	#instVars : [
		'quizProgress',
		'buttonNext',
		'buttonSkip',
		'questionWidget',
		'labelScore'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #specs }
MOPQuizWindow class >> defaultSpec [

	^ SpecColumnLayout composed
		newRow: [ :row |
			row add: #labelScore ] height: ComposableModel buttonHeight;
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
		icon: (self iconNamed: #forward);
		enabled: false.
		
	questionWidget := self instantiate: MOPInitialWidget.
	
	labelScore := self newLabel.
		
	self focusOrder
		add: buttonSkip;
		add: buttonNext
]

{ #category : #accessing }
MOPQuizWindow >> labelScore [
	^ labelScore
]

{ #category : #accessing }
MOPQuizWindow >> labelScore: anObject [
	labelScore := anObject
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
	questionWidget setDescription: quizProgress quiz description.
	labelScore label: quizProgress scoreString 
	
]

{ #category : #initialization }
MOPQuizWindow >> title [

	| quiz |
	quiz := quizProgress quiz.
	quiz
		ifNil: [ ^ 'Quiz' ]
		ifNotNil: [ ^ quiz name ]
]
