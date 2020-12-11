Class {
	#name : #MOPTestComparing,
	#superclass : #TestCase,
	#category : #'MOPQuiz-glorp'
}

{ #category : #tests }
MOPTestComparing >> testCompareAnswers [

	| a1 a2 |
	a1 := MOPAnswer new
		answerId: 1;
		text: 'Test';
		isRight: true.
	a2 := MOPAnswer new
		answerId: 1;
		text: 'Test';
		isRight: true.
	self assert: (a1 isTheSameAs: a2).
	
	a2 answerId: 2.
	self assert: (a1 isTheSameAs: a2) equals: false.
	
	a2
		answerId: 1;
		text: 'Foo'.
	self assert: (a1 isTheSameAs: a2) equals: false.
	
	a2
		text: 'Test';
		isRight: false.
	self assert: (a1 isTheSameAs: a2) equals: false
]

{ #category : #tests }
MOPTestComparing >> testCompareQuestions [

	| q1 q2 |
	q1 := MOPQuestion new
		questionId: 1;
		text: 'Test';
		type: 1.
	q2 := MOPQuestion new
		questionId: 1;
		text: 'Test';
		type: 1.
	self assert: (q1 isTheSameAs: q2).
	
	q2 questionId: 2.
	self assert: (q1 isTheSameAs: q2) equals: false.
	
	q2 questionId: 1.
	q1 answers add: (MOPAnswer new answerId: 1; text: 'Answer'; isRight: true).
	self assert: (q1 isTheSameAs: q2) equals: false.
	
	q2 answers add: (MOPAnswer new answerId: 1; text: 'Answer'; isRight: true).
	self assert: (q1 isTheSameAs: q2).
	
	q1 answers add: (MOPAnswer new answerId: 2; text: 'Another answer'; isRight: true).
	q2 answers add: (MOPAnswer new answerId: 2; text: 'Another answer'; isRight: false).
	self assert: (q1 isTheSameAs: q2) equals: false
]

{ #category : #tests }
MOPTestComparing >> testCompareQuizes [

	| quiz1 quiz2 |
	quiz1 := MOPQuiz new
		quizId: 1;
		name: 'Test';
		description: 'Test desc'.
	quiz2 := MOPQuiz new
		quizId: 1;
		name: 'Test';
		description: 'Test desc'.
	self assert: (quiz1 isTheSameAs: quiz2).
	
	
]
