# My Diary

My Diary is a SwiftUI iOS app that uses Firebase Authentication with Email/Password login to create a password-protected diary experience.

## Features

- Create account with email and password
- Log in with Firebase Authentication
- Stay signed in with session handling
- Log out
- Add simple diary entries during app use

## Project Structure

- `MyDiaryApp.swift` – app entry point and Firebase setup check
- `ContentView.swift` – routes user based on login state
- `AuthViewModel.swift` – handles signup, login, logout, and auth session
- `LoginView.swift` – login and account creation screen
- `DiaryHomeView.swift` – diary home screen after login
- `AddEntryView.swift` – create a new diary entry
- `DiaryEntry.swift` – diary entry model
- `FirebaseSetupRequiredView.swift` – shown if Firebase config is missing

## Important

This repository does **not** include the real `GoogleService-Info.plist` file.

To run the project, you must add your own Firebase configuration.

## Firebase Setup Instructions

### 1. Create a Firebase project
Create a project in Firebase Console.

### 2. Add an iOS app
Add an iOS app to the Firebase project using this bundle identifier:

`com.yourname.MyDiary`

Make sure the Xcode bundle identifier matches the Firebase bundle identifier.

### 3. Download the config file
Download `GoogleService-Info.plist` from Firebase.

### 4. Add the file to Xcode
Drag `GoogleService-Info.plist` into the Xcode project.

### 5. Enable Authentication
In Firebase Console:

Authentication → Sign-in method → Enable **Email/Password**

### 6. Add Firebase package dependencies
In Xcode, add Firebase using Swift Package Manager and include:

- `FirebaseAuth`
- `FirebaseCore`

## Notes

This project is designed as a simple password-protected diary app for a class assignment.

Current diary entries are stored only while the app is open. Authentication is handled with Firebase.
