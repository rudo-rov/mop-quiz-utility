Class {
	#name : #MOPTeapot,
	#superclass : #Object,
	#classVars : [
		'teapot'
	],
	#category : #'MOPQuiz-server'
}

{ #category : #control }
MOPTeapot class >> start [

	teapot := Teapot configure: { 
		#defaultOutput -> #ston.
		#port -> 8080.
		#bindAddress -> #[127 0 0 1].
	}.
	MOPDatabaseConnection resetSession. "To clear junk from debugging"
	
	teapot
		GET: '/hello' -> 'Hello world!';
		GET: '/quiz' -> MOPDatabaseConnection instance getAllQuizes;
		GET: '/quiz/<id>' -> [ :req | MOPDatabaseConnection instance getQuizWithId: (req at: #id) asInteger ];
		POST: '/quiz/<quizId>/question' -> [ :req |
			MOPDatabaseConnection instance
				createQuestionWithText: (req at: #text) 
				withType: (req at: #type) asInteger 
				forQuiz: (req at: #quizId) asInteger ];
		POST: '/quiz' -> [ :req | 
			MOPDatabaseConnection instance 
				createQuizWithName: (req at: #name) 
				withDescription: (req at: #description) ];
		POST: '/question/<qid>/answer' -> [ :req |
			MOPDatabaseConnection instance
				createAnswer: (req at: #text)
				isRight: (req at: #isRight)
				forQuestion: (req at: #qid) asInteger ];
		DELETE: '/quiz/<id>' -> [ :req | MOPDatabaseConnection instance deleteQuizWithId: (req at: #id) asInteger ];
		DELETE: '/quiz/<qid>/question/<id>' -> [ :req |
			MOPDatabaseConnection instance deleteQuestionWithId: (req at: #id) asInteger quizId: (req at: #qid) asInteger ];
		DELETE: '/question/<qid>/answer/<aid>' -> [ :req |
			MOPDatabaseConnection instance
				deleteAnswerWithId: (req at: #aid) asInteger
				forQuestion: (req at: #qid) asInteger ];
		exception: KeyNotFound -> (TeaResponse notFound body: 'This message is not understood.');
		start.
]

{ #category : #control }
MOPTeapot class >> stop [

	teapot stop
]
