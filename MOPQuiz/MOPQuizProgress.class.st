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
MOPQuizProgress >> currentQuestion [

	currentQuestion > 0
		ifTrue: [ ^ quiz questions at: currentQuestion ]
]

{ #category : #accessing }
MOPQuizProgress >> currentQuestionIndex [

	^ currentQuestion
]

{ #category : #accessing }
MOPQuizProgress >> initialize [

	score := 0.
	currentQuestion := 0
]

{ #category : #accessing }
MOPQuizProgress >> nextQuestion [

	currentQuestion = quiz questions size
		ifTrue: [ ^ nil ]. "Indicate the end of the quiz"
	currentQuestion := currentQuestion + 1.
	^ quiz questions at: currentQuestion
]

{ #category : #accessing }
MOPQuizProgress >> quiz [

	^ quiz
]

{ #category : #accessing }
MOPQuizProgress >> quiz: aMOPQuiz [

	quiz := aMOPQuiz.
	currentQuestion := 0
]

{ #category : #accessing }
MOPQuizProgress >> score [

	^ score
]

{ #category : #accessing }
MOPQuizProgress >> scoreString [

	^ 'Score: ', score asString
]

{ #category : #accessing }
MOPQuizProgress >> updateScore: anInteger [

	score := score + anInteger
]
