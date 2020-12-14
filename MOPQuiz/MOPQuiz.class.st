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
MOPQuiz >> initialize [

	questions := OrderedCollection new
]

{ #category : #comparing }
MOPQuiz >> isTheSameAs: aMOPQuiz [

	^ (quizId = aMOPQuiz quizId)
	& (name = aMOPQuiz name)
	& (description = aMOPQuiz description)
	& (self questionsAreTheSame: aMOPQuiz questions)
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

{ #category : #comparing }
MOPQuiz >> questionsAreTheSame: anOrderedCollection [

	questions size = anOrderedCollection size
		ifFalse: [ ^ false ].
		
	1 to: questions size do: [ :cnt |
		((questions at: cnt) isTheSameAs: (anOrderedCollection at: cnt))
			ifFalse: [ ^ false ] ].
		
	^ true
]

{ #category : #accessing }
MOPQuiz >> quizId [
	^ quizId
]

{ #category : #accessing }
MOPQuiz >> quizId: anObject [
	quizId := anObject
]
