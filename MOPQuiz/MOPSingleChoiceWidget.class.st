Class {
	#name : #MOPSingleChoiceWidget,
	#superclass : #DynamicComposableModel,
	#instVars : [
		'question',
		'labelQuestion',
		'radioGroup',
		'radiosAnswers',
		'pickedAnswer'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #'instance creation' }
MOPSingleChoiceWidget class >> on: aQuestion [

	| inst |
	inst := self basicNew.
	inst question: aQuestion.
	inst initialize.
	^ inst
]

{ #category : #actions }
MOPSingleChoiceWidget >> evaluateAnswer [

	pickedAnswer 
		ifNotNil: [ 
			pickedAnswer isRight
				ifTrue: [ ^ 1 ]
				ifFalse: [ ^ 0 ] ]
		ifNil: [ ^ 0 ]
	
]

{ #category : #initialization }
MOPSingleChoiceWidget >> initializePresenter [

	radioGroup buttons do: [ :button |
		button activationAction: [ 
			pickedAnswer := radiosAnswers at: button ] ]
]

{ #category : #initialization }
MOPSingleChoiceWidget >> initializeWidgets [

	labelQuestion := self newLabel.
	labelQuestion label: question text.
	radioGroup := RadioButtonGroup new.
	
	radiosAnswers := Dictionary new.
	1 to: question answers size do: [ :count |
		| model |
		model := self newRadioButton.
		model label: (question answers at: count) text.
		radioGroup addRadioButton: model.
		radiosAnswers at: model put: (question answers at: count).
		self assign: model to: ('answer_', count asString) asSymbol ]
]

{ #category : #accessing }
MOPSingleChoiceWidget >> labelQuestion [
	^ labelQuestion
]

{ #category : #accessing }
MOPSingleChoiceWidget >> labelQuestion: anObject [
	labelQuestion := anObject
]

{ #category : #initialization }
MOPSingleChoiceWidget >> layout [

	| mainCol |
	mainCol := SpecColumnLayout composed.
	mainCol newRow: [ :row | row add: #labelQuestion ] height: ComposableModel buttonHeight.
	1 to: question answers size do: [ :count |
		mainCol newRow: [ :row |
			row add: ('answer_', count asString) asSymbol ] height: ComposableModel buttonHeight ].
	^ mainCol
]

{ #category : #initialization }
MOPSingleChoiceWidget >> question: aMOPQuestion [

	question := aMOPQuestion 
]

{ #category : #accessing }
MOPSingleChoiceWidget >> radioGroup [
	^ radioGroup
]

{ #category : #accessing }
MOPSingleChoiceWidget >> radioGroup: anObject [
	radioGroup := anObject
]
