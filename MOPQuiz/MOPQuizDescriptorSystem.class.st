Class {
	#name : #MOPQuizDescriptorSystem,
	#superclass : #DescriptorSystem,
	#category : #'MOPQuiz-glorp'
}

{ #category : #'class models' }
MOPQuizDescriptorSystem >> classModelForMOPQuestion: aClassModel [

	aClassModel newAttributeNamed: #questionId.
	aClassModel newAttributeNamed: #text.
	aClassModel newAttributeNamed: #type.
	aClassModel newAttributeNamed: #answers collectionOf: MOPAnswer
]

{ #category : #'class models' }
MOPQuizDescriptorSystem >> classModelForMOPQuiz: aClassModel [

	aClassModel newAttributeNamed: #quizId.
	aClassModel newAttributeNamed: #name.
	aClassModel newAttributeNamed: #description.
	aClassModel newAttributeNamed: #questions collectionOf: MOPQuestion
]

{ #category : #'class models' }
MOPQuizDescriptorSystem >> classModelforMOPAnswer: aClassModel [

	aClassModel newAttributeNamed: #answerId.
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

{ #category : #'table models' }
MOPQuizDescriptorSystem >> tableForANSWER: aTable [

	(aTable createFieldNamed: 'answer_id' type: platform serial)
		bePrimaryKey.
	aTable createFieldNamed: 'question' type: platform integer. "Foreign key?"
	aTable createFieldNamed: 'text' type: platform text.
	aTable createFieldNamed: 'is_right' type: platform boolean  
]

{ #category : #'table models' }
MOPQuizDescriptorSystem >> tableForQUESTION: aTable [
	
	(aTable createFieldNamed: 'question_id' type: platform serial)
		bePrimaryKey.
	aTable createFieldNamed: 'quiz' type: platform integer.
	aTable createFieldNamed: 'text' type: platform text.
	aTable createFieldNamed: 'type' type: platform char
]

{ #category : #'table models' }
MOPQuizDescriptorSystem >> tableForQUIZ: aTable [

	(aTable createFieldNamed: 'quiz_id' type: platform serial)
		bePrimaryKey.
	aTable
		createFieldNamed: 'name' type: platform text.
	aTable
		createFieldNamed: 'description' type: platform text
]
