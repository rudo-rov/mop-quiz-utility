Class {
	#name : #MOPMessageModal,
	#superclass : #ComposableModel,
	#instVars : [
		'labelMessage',
		'buttonOk'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #specs }
MOPMessageModal class >> defaultSpec [

	^ SpecColumnLayout composed
		newRow: [ :row |
			row add: #labelMessage ];
		newRow: [ :row |
			row add: #buttonOk ] height: ComposableModel buttonHeight;
		yourself
]

{ #category : #accessing }
MOPMessageModal >> buttonOk [
	^ buttonOk
]

{ #category : #accessing }
MOPMessageModal >> buttonOk: anObject [
	buttonOk := anObject
]

{ #category : #initialization }
MOPMessageModal >> initializePresenter [

	buttonOk action: [ self window close ]
]

{ #category : #initialization }
MOPMessageModal >> initializeWidgets [
	
	labelMessage := self newLabel.
	
	buttonOk := self newButton
		label: 'OK';
		icon: (self iconNamed: #glamorousAccept).
		
	self focusOrder
		add: buttonOk
]

{ #category : #accessing }
MOPMessageModal >> labelMessage [
	^ labelMessage
]

{ #category : #accessing }
MOPMessageModal >> labelMessage: anObject [
	labelMessage := anObject
]

{ #category : #initialization }
MOPMessageModal >> setMessage: aString [

	labelMessage label: aString
]
