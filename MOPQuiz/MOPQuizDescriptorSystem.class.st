Class {
	#name : #MOPQuizDescriptorSystem,
	#superclass : #DescriptorSystem,
	#category : #'MOPQuiz-glorp'
}

{ #category : #'table models' }
MOPQuizDescriptorSystem >> allTableNames [

	^ #('QUIZ' 'QUESTION' 'ANSWER')
]

{ #category : #'class models' }
MOPQuizDescriptorSystem >> classModelForMOPQuestion: aClassModel [

	(aClassModel newAttributeNamed: #questionId) useDirectAccess: true.
	aClassModel newAttributeNamed: #text.
	aClassModel newAttributeNamed: #type.
	aClassModel newAttributeNamed: #answers collectionOf: MOPAnswer
]

{ #category : #'class models' }
MOPQuizDescriptorSystem >> classModelForMOPQuiz: aClassModel [

	(aClassModel newAttributeNamed: #quizId) useDirectAccess: true.
	aClassModel newAttributeNamed: #name.
	aClassModel newAttributeNamed: #description.
	aClassModel newAttributeNamed: #questions collectionOf: MOPQuestion
]

{ #category : #'class models' }
MOPQuizDescriptorSystem >> classModelforMOPAnswer: aClassModel [

	(aClassModel newAttributeNamed: #answerId) useDirectAccess: true.
	aClassModel newAttributeNamed: #text.
	aClassModel newAttributeNamed: #isRight
]

{ #category : #descriptors }
MOPQuizDescriptorSystem >> descriptorForMOPAnswer: aDescriptor [

	| table |
	table := self tableNamed: 'ANSWER'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #answerId
		to: (table fieldNamed: 'answer_id').
	(aDescriptor newMapping: DirectMapping)
		from: #text
		to: (table fieldNamed: 'text').
	(aDescriptor newMapping: DirectMapping)
		from: #isRight
		to: (table fieldNamed: 'is_right')
]

{ #category : #descriptors }
MOPQuizDescriptorSystem >> descriptorForMOPQuestion: aDescriptor [

	| table |
	table := self tableNamed: 'QUESTION'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #questionId
		to: (table fieldNamed: 'question_id').
	(aDescriptor newMapping: DirectMapping)
		from: #text
		to: (table fieldNamed: 'text').
	(aDescriptor newMapping: DirectMapping)
		from: #type
		to: (table fieldNamed: 'type').
	(aDescriptor newMapping: ToManyMapping)
		attributeName: #answers;
		beExclusive;
		referenceClass: MOPAnswer	
]

{ #category : #descriptors }
MOPQuizDescriptorSystem >> descriptorForMOPQuiz: aDescriptor [

	| table |
	table := self tableNamed: 'QUIZ'.
	aDescriptor table: table.
	(aDescriptor newMapping: DirectMapping)
		from: #quizId
		to: (table fieldNamed: 'quiz_id').
	(aDescriptor newMapping: DirectMapping)
		from: #name
		to: (table fieldNamed: 'name').
	(aDescriptor newMapping: DirectMapping)
		from: #description
		to: (table fieldNamed: 'description').
	(aDescriptor newMapping: ToManyMapping)
		attributeName: #questions;
		referenceClass: MOPQuestion
]

{ #category : #'table models' }
MOPQuizDescriptorSystem >> tableForANSWER: aTable [

	| questionField |
	(aTable createFieldNamed: 'answer_id' type: platform sequence) bePrimaryKey.
	questionField := aTable createFieldNamed: 'question_id' type: platform integer.
	aTable createFieldNamed: 'text' type: platform text.
	aTable createFieldNamed: 'is_right' type: platform boolean.
	
	aTable
		addForeignKeyFrom: questionField
		to: ((self tableNamed: 'QUESTION') fieldNamed: 'question_id').
]

{ #category : #'table models' }
MOPQuizDescriptorSystem >> tableForQUESTION: aTable [
	
	| quizField |
	(aTable createFieldNamed: 'question_id' type: platform sequence)
		bePrimaryKey.
	quizField := aTable createFieldNamed: 'quiz_id' type: platform integer.
	aTable createFieldNamed: 'text' type: platform text.
	aTable createFieldNamed: 'type' type: platform integer.
	
	aTable
		addForeignKeyFrom: quizField
		to: ((self tableNamed: 'QUIZ') fieldNamed: 'quiz_id')
]

{ #category : #'table models' }
MOPQuizDescriptorSystem >> tableForQUIZ: aTable [

	(aTable createFieldNamed: 'quiz_id' type: platform sequence)
		bePrimaryKey.
	aTable
		createFieldNamed: 'name' type: platform text.
	aTable
		createFieldNamed: 'description' type: platform text
]
