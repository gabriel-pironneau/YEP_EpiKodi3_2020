# YEP_EpiKodi3_2020

## Description

3rd year free chosen project in which the goal is to implement a __Media Center Desktop Application__ that allows users to play and view most videos, music, podcasts, and other digital media files from local and network storage media and the internet.
It is inspired from the famous __Kodi Media Center Application__ : [Kodi]( https://kodi.tv/).


The user can chose which services he/she wants to use.
For now the application is very basics and cover only Movies & Musics Media Players.


An authentification system is also present, so the user can select and save files to his/her personal space.


Currently, the available functionalities are :

* **YouTube Video Player**

* **MixCloud Music Player**

* **Local Storage Movie Player**

* **Users Sessions**

## Requirements

| Technology    | Version |
|:-------       | -------:|
| Python | v3+ |
| Pip | v20+ |
| Flutter | v+ |
| JavaFx | v+ |

You might be able to run the project with versions older than those listed above.

## How to setup the project

In order to start the project, you need to have the requirements satisfied.

To run the **server** : 1) Navigate to ./server folder 2) `pip install -r requirements.txt` 3) `python run.py` 4) and don't forget to read the endpoints documentation (*folder documentation*) in case of single server tests ;).

To build and run the **web client** : 1) Navigate to ./desktop


## What are the different technologies used for the project

### Flask & Python

Used as the __server__ and __backend__ framework for the project, it is responsible of for the process and interaction with third-party APIs to fetch datas for all services supported by the application as well as the file transfer protocol and user module management.


Note: check out __Endpoints.md__ for further details.


Runs on:

* `127.0.0.1:5000`.

### Cloud Firestore/Firebase

Used as the database for the project it is set-up locally.
Datas are organized into collections with clean separation.
User management module is created here and managed directly by the server.


Runs on:

* `127.0.0.1:5000`.


### JavaFx

Used as the desktop client. It is responsible of the display and visually structured all the datas for the user experience.
It is also responsible for the creation & handling of media players.


Runs on:

* `localhost:8080` for local machine.


### Flutter

Used as the Mobile client. It is responsible of the display and visually structured all the datas for the user experience.
It is also responsible for the creation & handling of media players as well as the generation of client APK.


## Contributors

### Back End Developer

gabriel.pironneau@epitech.eu

### Desktop Developers

hugo.lacour@epitech.eu
gabriel.pironneau@epitech.eu

### Mobile Developer

benjamin.amory@epitech.eu
