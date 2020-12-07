Class {
	#name : #MOPInitialWidget,
	#superclass : #ComposableModel,
	#instVars : [
		'labelDescription'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #specs }
MOPInitialWidget class >> defaultSpec [

	^ SpecColumnLayout composed
		newRow: [ :row |
			row add: #labelDescription ];
		yourself
]

{ #category : #initialization }
MOPInitialWidget >> initializeWidgets [
	
	labelDescription := self newLabel
]

{ #category : #accessing }
MOPInitialWidget >> labelDescription [
	^ labelDescription
]

{ #category : #accessing }
MOPInitialWidget >> labelDescription: anObject [
	labelDescription := anObject
]

{ #category : #accessing }
MOPInitialWidget >> setDescription: aString [

	labelDescription 
		label: aString
]
