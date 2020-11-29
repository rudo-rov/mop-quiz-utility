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
		#defaultOutput -> #json.
		#port -> 8080.
		#bindAddress -> #[127 0 0 1].
	}.
	
	teapot
		GET: '/hello' -> 'Hello world!';
		exception: KeyNotFound -> (TeaResponse notFound body: 'This message is not understood.');
		start.
]

{ #category : #control }
MOPTeapot class >> stop [

	teapot stop
]
