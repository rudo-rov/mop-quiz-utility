Class {
	#name : #MOPMainWindow,
	#superclass : #ComposableModel,
	#instVars : [
		'listQuiz',
		'buttonAdd',
		'buttonDelete',
		'buttonModify',
		'buttonStart'
	],
	#category : #'MOPQuiz-user-interface'
}

{ #category : #specs }
MOPMainWindow class >> defaultSpec [

	^ SpecLayout composed
		newColumn: [ :col | 
			col 
				newRow: [ :row |
					row add: #buttonAdd; add: #buttonModify; add: #buttonDelete ] height: ComposableModel buttonHeight;
				newRow: [ :row |
					row add: #listQuiz ];
				newRow: [ :row |
					row add: #buttonStart ] height: ComposableModel buttonHeight 
		];	
		yourself
]

{ #category : #accessing }
MOPMainWindow >> buttonAdd [
	^ buttonAdd
]

{ #category : #accessing }
MOPMainWindow >> buttonAdd: anObject [
	buttonAdd := anObject
]

{ #category : #accessing }
MOPMainWindow >> buttonDelete [
	^ buttonDelete
]

{ #category : #accessing }
MOPMainWindow >> buttonDelete: anObject [
	buttonDelete := anObject
]

{ #category : #accessing }
MOPMainWindow >> buttonModify [
	^ buttonModify
]

{ #category : #accessing }
MOPMainWindow >> buttonModify: anObject [
	buttonModify := anObject
]

{ #category : #accessing }
MOPMainWindow >> buttonStart [
	^ buttonStart
]

{ #category : #accessing }
MOPMainWindow >> buttonStart: anObject [
	buttonStart := anObject
]

{ #category : #initialization }
MOPMainWindow >> extent [

	^ 500@400
]

{ #category : #initialization }
MOPMainWindow >> initializePresenter [

	buttonModify action: [ self onModifyClick ].
	buttonAdd action: [ 
		| createWindow |
		createWindow := MOPQuizCreate new. 
		createWindow quizes: listQuiz.
		createWindow openWithSpec modalRelativeTo: World ].
	buttonDelete action: [ self onDeleteClick ].
	buttonStart action: [ self onStartClick ]
]

{ #category : #initialization }
MOPMainWindow >> initializeWidgets [
	
	| quizes |
	buttonAdd := self newButton.
	buttonDelete := self newButton.
	buttonModify := self newButton.
	listQuiz := self newList.
	
	buttonAdd
		label: 'Add';
		icon: (self iconNamed: #add).
	buttonDelete
		label: 'Delete';
		icon: (self iconNamed: #changeRemove).
	buttonModify 
		label: 'Modify';
		icon: (self iconNamed: #edit).
	buttonStart := self newButton
		label: 'Start quiz';
		icon: (self iconNamed: #glamorousGo).
	
	quizes := MOPApiRequests new getAllQuizes.	
	listQuiz
		items: quizes;
		displayBlock: [ :quiz | quiz name ];
		sortingBlock: [ :quizA :quizB | quizA quizId < quizB quizId ]
]

{ #category : #accessing }
MOPMainWindow >> listQuiz [
	^ listQuiz
]

{ #category : #accessing }
MOPMainWindow >> listQuiz: anObject [
	listQuiz := anObject
]

{ #category : #actions }
MOPMainWindow >> onDeleteClick [

	| selectedQuiz newList |
	selectedQuiz := listQuiz selectedItem.
	selectedQuiz ifNotNil: [ 
		newList := MOPApiRequests new deleteQuizWithId: selectedQuiz quizId ].
	
	listQuiz items: newList
]

{ #category : #actions }
MOPMainWindow >> onModifyClick [

	| selectedQuiz |
	selectedQuiz := listQuiz selectedItem.
	selectedQuiz ifNotNil: [
		| modifyWindow | 
		modifyWindow := (MOPQuizModify new setQuiz: selectedQuiz) openWithSpec.
		modifyWindow modalRelativeTo: World ]
]

{ #category : #actions }
MOPMainWindow >> onStartClick [

	| selectedQuiz |
	selectedQuiz := listQuiz selectedItem.
	selectedQuiz 
		ifNil: [ 
			| errorModal |
			errorModal := MOPMessageModal new
				setMessage: 'No quiz is selected.'.
				errorModal openWithSpec modalRelativeTo: self ]
		ifNotNil: [ 
			selectedQuiz questions
				ifEmpty: [ 
					| errorModal |
					errorModal := MOPMessageModal new
						setMessage: 'Selected quiz has no questions.'.
						errorModal openWithSpec modalRelativeTo: self ]
				ifNotEmpty: [ 
					| quizWindow newProgress |
					quizWindow := MOPQuizWindow new.
					newProgress := MOPQuizProgress new
						quiz: selectedQuiz.
					quizWindow quizProgress: newProgress.
					quizWindow openWithSpec ] ]
		
	
	
]

{ #category : #accessing }
MOPMainWindow >> title [

	^ 'MOP Quiz Utility'
]
