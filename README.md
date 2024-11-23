# Table of Contents

1. [Daily Journal App](#daily-journal-app)
2. [Download Apk Directly](#download-apk-directly)
3. [Features](#features)
   - [Authentication Page](#authentication-page)
   - [Home Page](#home-page)
   - [Create Journal Page](#create-journal-page)
   - [Display Journal Page](#display-journal-page)
4. [Screenshots](#screenshots)
5. [Technologies Used](#technologies-used)
6. [Development Environment Setup](#development-environment-setup)
   - [Prerequisites](#prerequisites)
     - [Install Flutter](#1--install-flutter)
     - [Install Dart SDK](#2--install-dart-sdk)
     - [Install IDE or Code Editor](#3--install-ide-or-code-editor)
     - [Install Firebase CLI](#4--install-firebase-cli)
7. [Project Setup](#project-setup)
   - [Clone the Repository](#clone-the-repository)
   - [Install Dependencies](#for-installing-dependencies-run-the-following-command-to-fetch-all-dependencies-mentioned-in-the-pubspecyaml-file)
   - [Set Up Firebase](#set-up-firebase)
   - [Run the Application](#run-the-application-to-start-the-app-on-a-connected-device-or-emulator)
8. [Running Tests](#running-tests)
9. [Further Reading](#further-reading)

<h1>Daily Journal App</h1>

<p>The Daily Journal app is a Flutter application developed to help users record and manage their daily thoughts and experiences. This app utilizes Firebase, a cloud-based backend service, for user authentication and storage. The app consists of four main pages: authentication, home, create journal, and display journal.</p>

<h2>Download Apk Directly</h2>
<p>Download the apk file from the GitHub repository and install it on your device.</p>
    
- [Apk Path! click here](./app-release.apk) 
error downloading? the apk is present in root directory of the repo

<h2>Features</h2>

<ul>
  <li><strong>Authentication Page:</strong> This page allows users to log in if they have an existing account or sign up if they are new users. It provides secure user authentication using Firebase Authentication.</li>
  <li><strong>Home Page:</strong> The home page displays a list of the user's journal entries and includes a drawer with simple user details and a sign-out button.</li>
  <li><strong>Create Journal Page:</strong> Users can create a new journal entry using a form provided on this page. The entries are stored in Firebase Firestore for future retrieval.</li>
  <li><strong>Display Journal Page:</strong> This page displays detailed information about a specific journal entry, including the date and content. Users can also delete a journal entry if needed.</li>
</ul>

<h2>Screenshots</h2>

<table>
  <tr>
    <th>Login Page</th>
    <th>Home Page</th>
    <th>Create Journal Page</th>
    <th>Display Journal Page</th>

  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/0206d1f9-986e-4f47-93c4-94928ef507b8" width="300" height="450" /></td>
    <td><img src="https://github.com/user-attachments/assets/1eefec8d-c9ab-42dc-8f52-fc2524718a78" width="300" height="450"/></td>
    <td><img src="https://github.com/user-attachments/assets/727886dd-bf01-47de-a16a-03280befcc38" width="300" height="450" /></td>
    <td><img src="https://github.com/user-attachments/assets/386e0f3e-7d91-4f71-bd04-99bbef2026ba" width="300" height="450" /></td>
  </tr>
</table>

<h2>Technologies Used</h2>

<ul>
  <li>Flutter: A cross-platform framework for developing mobile applications.</li>
  <li>Firebase Authentication: Provides user authentication, login, and sign-up functionality.</li>
  <li>Firebase Firestore: A NoSQL database for storing and managing journal entries.</li>
</ul>

# Development Environment Setup

## Prerequisites

### 1- Install Flutter

Ensure Flutter is installed on your system. Follow the [official Flutter installation guide](https://docs.flutter.dev/get-started/install) for your operating system.

    # Verify Flutter installation by running this command in terminal
    flutter doctor

Make sure there are no unresolved issues before proceeding.

### 2- Install Dart SDK

Flutter comes bundled with the Dart SDK. Ensure it's properly installed by checking the Dart version:

    dart --version

### 3- Install IDE or Code Editor

Use an IDE like Android Studio or Visual Studio Code with Flutter and Dart plugins.

### 4- Install Firebase CLI

Install the Firebase CLI to initialize Firebase in your project.

    npm install -g firebase-tools
    firebase login

# Project Setup

### Clone the Repository

    git clone <repository-url>
    cd daily_journal

For Installing Dependencies Run the following command to fetch all dependencies mentioned in the pubspec.yaml file:

    flutter pub get

### Set Up Firebase

Install the FlutterFire CLI to configure Firebase.

    dart pub global activate flutterfire_cli

Initialize Firebase in the project:

    flutterfire configure

This generates the firebase_options.dart file with platform-specific Firebase configurations.

### Run the Application To start the app on a connected device or emulator:

    flutter run

# Running Tests

Run All Unit Tests The project includes unit tests located in the test directory. Use the following command to execute all tests:

    flutter test

This documentation should guide developers in setting up and running the project efficiently while adhering to best practices. For additional help, refer to the [official Flutter documentation](https://docs.flutter.dev/).
