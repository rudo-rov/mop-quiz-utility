# Quiz utility
Semestral work for NI-MOP at FIT CTU, winter semester of 2020/2021.

## Overview
This is a utility that allows the user to create various quizes and then test their knowledge.

It uses a simple PosgreSQL database to save created quizes. There's a simple API built on top of this database and a client application that uses this API.

## Used technology
* PostgreSQL database for persistence (3 tables)
* Glorp with P3 for ORM
* simple API built using Teapot
* STON for object serialization and deserialization
* client application with graphical user interface built using Spec and Zinc (for HTTP requests)

## Functionality
Application allows user to create multiple quizes. These can contain questions of 3 types:
* Single-choice questions - multiple answers to choose from, one correct answer,
* Multiple-choice questions - multiple answers, multiple possible correct answers,
* Text questions - answer is written in the text field, there are multiple possible correct answers (or variations of 1 possible corrext answer).

The graphical utility allows the user to create new quizes, delete existing ones. User can also modify quizes - create and delete questions, create and
delete answers to questions. User can also take the quiz - questions are presented in the order they were added, user interface adapts to the type of question.
In the end, user is presented with the achieved score (the score is not persisted anywhere).

## Running the program
Before starting the server and client part of the program, it is necessary to have the PostgreSQL database running.
There may be a need to edit some configuration details (username/password to access the database, name of the database).
This can be done in method `MOPDatabaseConnection >> initialize`.

To run the program, execute this snippet in the Playground:

```Smalltalk
MOPDatabaseConnection instance recreateTables. "Creates/Recreates the tables in the database"
MOPDatabaseConnection instance createSampleData. "Creates some sample data to demonstrate the program"
MOPTeapot start. "Starts an instance of Teapot server"
MOPMainWindow new openWithSpec "Opens the main window of the client application"
```
