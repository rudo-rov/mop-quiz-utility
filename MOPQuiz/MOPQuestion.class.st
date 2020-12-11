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
MOPQuestion >> answersAreTheSame: anOrderedCollection [

	answers size = anOrderedCollection size
		ifFalse: [ ^ false ].
		
	1 to: answers size do: [ :cnt |
		((answers at: cnt) isTheSameAs: (anOrderedCollection at: cnt))
			ifFalse: [ ^ false ] ].
		
	^ true
]

{ #category : #accessing }
MOPQuestion >> initialize [
	
	answers := OrderedCollection new
]

{ #category : #accessing }
MOPQuestion >> isTheSameAs: aMOPQuestion [

	^ (questionId = aMOPQuestion questionId)
	& (text = aMOPQuestion text)
	& (type = aMOPQuestion type)
	& (self answersAreTheSame: aMOPQuestion answers)
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
