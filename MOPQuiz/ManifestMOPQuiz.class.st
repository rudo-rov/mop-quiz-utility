"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMOPQuiz,
	#superclass : #PackageManifest,
	#category : #'MOPQuiz-Manifest'
}

{ #category : #'code-critics' }
ManifestMOPQuiz class >> ruleRBUncommonMessageSendRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'MOPTeapot class' #start #true)) #'2020-12-01T19:03:14.434434+01:00') )
]
