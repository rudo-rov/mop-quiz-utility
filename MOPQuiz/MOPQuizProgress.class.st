Class {
	#name : #MOPQuizProgress,
	#superclass : #Object,
	#instVars : [
		'quiz',
		'currentQuestion',
		'score'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #accessing }
MOPQuizProgress >> initialize [

	score := 0
]

{ #category : #accessing }
MOPQuizProgress >> quiz [

	^ quiz
]

{ #category : #accessing }
MOPQuizProgress >> quiz: aMOPQuiz [

	quiz := aMOPQuiz.
	currentQuestion := 1
]

{ #category : #accessing }
MOPQuizProgress >> scoreString [

	^ 'Score: ', score asString
]
