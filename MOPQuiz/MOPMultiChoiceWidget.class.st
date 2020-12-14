Class {
	#name : #MOPMultiChoiceWidget,
	#superclass : #DynamicComposableModel,
	#instVars : [
		'question',
		'labelQuestion',
		'checkAnswers',
		'selectedAnswers'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #'instance creation' }
MOPMultiChoiceWidget class >> on: aQuestion [

	| inst |
	inst := self basicNew.
	inst question: aQuestion.
	inst initialize.
	^ inst
]

{ #category : #accessing }
MOPMultiChoiceWidget >> checkAnswers [
	^ checkAnswers
]

{ #category : #accessing }
MOPMultiChoiceWidget >> checkAnswers: anObject [
	checkAnswers := anObject
]

{ #category : #accessing }
MOPMultiChoiceWidget >> evaluateAnswer [

	(selectedAnswers allSatisfy: [ :answer | answer isRight ])
		ifTrue: [ 
			((question answers reject: [ :each | selectedAnswers includes: each ]) allSatisfy: [ :each |
				each isRight = false ])
					ifTrue: [ ^ 1 ]
					ifFalse: [ ^ 0 ] ]
		ifFalse: [ ^ 0 ]
	 "TODO: and every non-selected item is incorrect"
]

{ #category : #accessing }
MOPMultiChoiceWidget >> initializePresenter [

	checkAnswers keysDo: [ :checkBox |
		checkBox activationAction: [ 
			selectedAnswers add: (checkAnswers at: checkBox) ].
		checkBox deactivationAction: [ 
			selectedAnswers remove: (checkAnswers at: checkBox) ] ]
]

{ #category : #accessing }
MOPMultiChoiceWidget >> initializeWidgets [

	selectedAnswers := Set new.
	labelQuestion := self newLabel
		label: question text.
		
	checkAnswers := Dictionary new.	
	1 to: question answers size do: [ :count |
		| model |
		model := self newCheckBox.
		model label: (question answers at: count) text.
		checkAnswers at: model put: (question answers at: count).
		self assign: model to: ('answer_', count asString) asSymbol ]
]

{ #category : #accessing }
MOPMultiChoiceWidget >> labelQuestion [
	^ labelQuestion
]

{ #category : #accessing }
MOPMultiChoiceWidget >> labelQuestion: anObject [
	labelQuestion := anObject
]

{ #category : #accessing }
MOPMultiChoiceWidget >> layout [

	| mainCol |
	mainCol := SpecColumnLayout composed.
	mainCol newRow: [ :row | row add: #labelQuestion ] height: ComposableModel buttonHeight.
	1 to: question answers size do: [ :count |
		mainCol newRow: [ :inRow |
			inRow add: ('answer_', count asString) asSymbol ] height: ComposableModel buttonHeight ].
	^ mainCol
]

{ #category : #accessing }
MOPMultiChoiceWidget >> question: anObject [
	question := anObject
]
