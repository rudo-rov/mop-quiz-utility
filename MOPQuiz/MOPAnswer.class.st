Class {
	#name : #MOPAnswer,
	#superclass : #Object,
	#instVars : [
		'answerId',
		'text',
		'isRight'
	],
	#category : #'MOPQuiz-glorp'
}

{ #category : #accessing }
MOPAnswer >> answerId [
	^ answerId
]

{ #category : #accessing }
MOPAnswer >> answerId: anObject [
	answerId := anObject
]

{ #category : #accessing }
MOPAnswer >> isRight [
	^ isRight
]

{ #category : #accessing }
MOPAnswer >> isRight: anObject [
	isRight := anObject
]

{ #category : #comparing }
MOPAnswer >> isTheSameAs: aMOPAnswer [

	^ (answerId = aMOPAnswer answerId)
	& (isRight = aMOPAnswer isRight)
	& (text = aMOPAnswer text)
]

{ #category : #accessing }
MOPAnswer >> text [
	^ text
]

{ #category : #accessing }
MOPAnswer >> text: anObject [
	text := anObject
]
