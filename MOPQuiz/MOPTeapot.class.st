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
		POST: '/quiz' -> [ :req | 
			MOPDatabaseConnection instance 
				createQuizWithName: (req at: #name) 
				withDescription: (req at: #description) ];
		DELETE: 'quiz/<id>' -> [ :req | MOPDatabaseConnection instance deleteQuizWithId: (req at: #id) asInteger ];
		exception: KeyNotFound -> (TeaResponse notFound body: 'This message is not understood.');
		start.
]

{ #category : #control }
MOPTeapot class >> stop [

	teapot stop
]
