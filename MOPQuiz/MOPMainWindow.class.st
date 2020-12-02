Class {
	#name : #MOPMainWindow,
	#superclass : #ComposableModel,
	#instVars : [
		'listQuiz',
		'buttonAdd',
		'buttonDelete',
		'buttonModify'
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
					row add: #listQuiz ] 
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

{ #category : #initialization }
MOPMainWindow >> initializePresenter [

	buttonModify action: [ self onModifyClick ].
	buttonAdd action: [ 
		| createWindow |
		createWindow := MOPQuizCreate new. 
		createWindow quizes: listQuiz.
		createWindow openWithSpec modalRelativeTo: World ].
	buttonDelete action: [ self onDeleteClick ]
]

{ #category : #initialization }
MOPMainWindow >> initializeWidgets [
	
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
		
	listQuiz
		items: MOPApiRequests new getAllQuizes;
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

{ #category : #initialization }
MOPMainWindow >> onDeleteClick [

	| selectedQuiz newList |
	selectedQuiz := listQuiz selectedItem.
	selectedQuiz ifNotNil: [ 
		newList := MOPApiRequests new deleteQuizWithId: selectedQuiz quizId ].
	
	listQuiz items: newList
]

{ #category : #initialization }
MOPMainWindow >> onModifyClick [

	| selectedQuiz |
	selectedQuiz := listQuiz selectedItem.
	selectedQuiz ifNotNil: [
		| modifyWindow | 
		modifyWindow := (MOPQuizModify new setQuiz: selectedQuiz) openWithSpec.
		modifyWindow modalRelativeTo: World ]
]

{ #category : #accessing }
MOPMainWindow >> title [

	^ 'MOP Quiz Utility'
]
