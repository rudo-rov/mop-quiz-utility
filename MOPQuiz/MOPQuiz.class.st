Class {
	#name : #MOPQuiz,
	#superclass : #Object,
	#instVars : [
		'quizId',
		'name',
		'description',
		'questions'
	],
	#category : #'MOPQuiz-glorp'
}

{ #category : #accessing }
MOPQuiz >> description [
	^ description
]

{ #category : #accessing }
MOPQuiz >> description: anObject [
	description := anObject
]

{ #category : #accessing }
MOPQuiz >> name [
	^ name
]

{ #category : #accessing }
MOPQuiz >> name: anObject [
	name := anObject
]

{ #category : #accessing }
MOPQuiz >> questions [
	^ questions
]

{ #category : #accessing }
MOPQuiz >> questions: anObject [
	questions := anObject
]

{ #category : #accessing }
MOPQuiz >> quizId [
	^ quizId
]

{ #category : #accessing }
MOPQuiz >> quizId: anObject [
	quizId := anObject
]
