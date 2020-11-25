Class {
	#name : #MOPQuestion,
	#superclass : #Object,
	#instVars : [
		'questionId',
		'text',
		'type',
		'answers'
	],
	#category : #'MOPQuiz-glorp'
}

{ #category : #accessing }
MOPQuestion >> answers [
	^ answers
]

{ #category : #accessing }
MOPQuestion >> answers: anObject [
	answers := anObject
]

{ #category : #accessing }
MOPQuestion >> questionId [
	^ questionId
]

{ #category : #accessing }
MOPQuestion >> questionId: anObject [
	questionId := anObject
]

{ #category : #accessing }
MOPQuestion >> text [
	^ text
]

{ #category : #accessing }
MOPQuestion >> text: anObject [
	text := anObject
]

{ #category : #accessing }
MOPQuestion >> type [
	^ type
]

{ #category : #accessing }
MOPQuestion >> type: anObject [
	type := anObject
]
