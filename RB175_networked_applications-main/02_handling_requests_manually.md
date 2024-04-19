# [Handling Requests Manually](https://launchschool.com/lessons/cac53b94/assignments)

## [Introduction](https://launchschool.com/lessons/cac53b94/assignments/9cd19cf9)

- What is involved with responding to http requests the hard way (ie. without the nifty tools we'll learn about in a sec)
- Rememeber that a http exchange is just a client and server sending text to each other.
- You won't need to use this technique in most production application, but the deep-dive is a great learning tool.

## [Coding Along with This Course](https://launchschool.com/lessons/cac53b94/assignments/1cd7539f)

- In the previous course it was said that a server is actually lots of different things working together, possibly in different places. 
- Well, in this part of the course we aren't using a database so the server is only one thing: the application server.
- This is a typical way for devs to work. If they're only using their personal machine, nothing more is necessary and you can just focus on the application code.
- It's when the code is deployed that other parts become necessary.
- This part of the course will concentrate on:
  - application code
  - HTTP
- and ignore:
  - server infrastructure:
    - web servers.
    - data stores.
- TCP is the protocol for HTTP requests, so is what we'll be looking at here.
- Keep the following image in mind while we're building our own TCP(AKA HTTP) server:

<img width="869" alt="Screenshot 2023-06-14 at 16 21 26" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/285b31b4-d5ae-46d7-9796-27b12bc596f7">


## [A Simple Echo Server](https://launchschool.com/lessons/cac53b94/assignments/a32ebc5e)

<img width="532" alt="Screenshot 2023-06-15 at 13 21 22" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/cf3f8f52-f4bc-4d25-80a2-80676aec73d2">

<img width="1220" alt="Screenshot 2023-06-15 at 13 16 19" src="https://github.com/SandyRodger/RB175_networked_applications/assets/78854926/9567de53-90b2-4a92-8ddd-1ba37c3cb226">

- This isn't working. Here are some solutions I'm trying:
  - A million things on chrome and Safari...
  - Download Firefox and try it on there. OK this was apparently a solution.

## [Parsing Path and Parameters](https://launchschool.com/lessons/cac53b94/assignments/4d46009e)


## [Sending a Complete Response](https://launchschool.com/lessons/cac53b94/assignments/65b0e271)


## [Persisting State in the URL](https://launchschool.com/lessons/cac53b94/assignments/3e3dd1f9)

- Cool!

## [Dealing with Empty Requests](https://launchschool.com/lessons/cac53b94/assignments/423845e1)

- I cant seem to emulate this error

## [Summary](https://launchschool.com/lessons/cac53b94/assignments/d5f4cb26)

- HTTP is text based, so this lesson was all abput messing with it entirely as a text file.
- HTTP is made up of TCP. This is the protocol at the Transport layer. Its job is talking between 2 computers.
- URLs are made up of different parts (I knew this)
- Params are addewd with `&`s. Obvs.
- HTTP is stateless which means you have to dance around to make it look like it isn't.

## Overview

|  | Once | Twice | Thrice | Comprehension | Retention
| :--- | :---: | :---: | :---: | :--- | :---
|1	Introduction| 14.6.23|
|2	Coding Along with This Course| 14.6.23|
|3	A Simple Echo Server|15.6.23|
|4	Parsing Path and Parameters|16.6.23|
|5	Sending a Complete Response|16.6.23|
|6	Persisting State in the URL|17.6.23|
|7	Dealing with Empty Requests|17.6.23|
|8	Summary|17.6.23|
