Class {
	#name : #MOPQuestionWidgetFactory,
	#superclass : #Object,
	#instVars : [
		'dict'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #initialization }
MOPQuestionWidgetFactory >> forQuestion: aMOPQuestion [

	^ dict 
		at: aMOPQuestion type
		ifAbsent: [ MOPMultiChoiceWidget ]
]

{ #category : #initialization }
MOPQuestionWidgetFactory >> initialize [

	dict := Dictionary newFrom: { 
		1 -> MOPSingleChoiceWidget.
		2 -> MOPMultiChoiceWidget.
		3 -> MOPTextAnswerWidget }
]
