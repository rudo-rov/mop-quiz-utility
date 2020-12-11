Class {
	#name : #MOPMainWindowTest,
	#superclass : #MOPInterfaceTest,
	#category : #'MOPQuiz-user-interface-test'
}

{ #category : #running }
MOPMainWindowTest >> setUp [

	super setUp
]

{ #category : #running }
MOPMainWindowTest >> tearDown [ 

	super tearDown
]

{ #category : #running }
MOPMainWindowTest >> testWindowInitialization [

	| window quizes |
	window := MOPMainWindow new.
	window buildWithSpec.
	quizes := session read: MOPQuiz.
	
	self assert: window listQuiz listItems size equals: quizes size.
	
	1 to: quizes size do: [ :cnt |
		self assert: ((window listQuiz listItems at: cnt) isTheSameAs: (quizes at: cnt)) ]
]
