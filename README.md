# 💰 Expense Tracker App

A clean, modern **personal expense tracking application** built with **Flutter**, **Firebase**, and **Riverpod**, designed to help users monitor spending, gain financial clarity, and build better money habits.

---

## ✨ Features

### 🔐 Authentication

- Email & password authentication (Firebase Auth)

- Login & Sign up flows

- Email verification

- Secure logout

- Auth state handling with Riverpod

### 💸 Expense Management (CRUD)

- Add new expenses

- View expense list

- Update existing expenses

- Delete expenses

- Real-time sync with Firebase Firestore

### 📊 Expense Summary

- Daily, weekly, and monthly totals

- Clean dashboard overview

- Pull-to-refresh support

### 🔍 Search & Filtering

- Search expenses by title or amount

- Instant filtering on the home screen

### 👤 Profile (Planned / In Progress)

- Display user info

- Update profile details

- Future: profile photo & preferences

### 🎨 Modern UI / UX

- GitHub/GitLab-inspired clean layout

- Light & Dark mode support

- Custom splash screen & adaptive app icon

- Responsive layout

### ⚡ Architecture

This application follows Clean Architecture to ensure clear separation of concerns, scalability, and testability.

Features are organized independently and structured into presentation, application, domain, and data layers.
State management and business flow are handled using Riverpod, while Firebase is used for authentication and data persistence.

Shared components such as configuration, routing, theming, utilities, and dependency injection are centralized to keep features isolated and maintainable.

---

## 🛠 Tech Stack

- **Flutter (Material 3)**

- **Dart**

- **Firebase**
  - Firebase Authentication
  - Cloud Firestore

- **Riverpod** (State Management)

- **GetIt** (Dependency Injection)

- **GoRouter** (Navigation)

- **Firebase Emulator Suite** (Local development)

## 📱 Screens

- Splash Screen

- Login Screen

- Sign Up Screen

- Home (Financial Overview)

- Add Expense

- View Expense

## 🚀 Getting Started

1️⃣ **Clone the repository**

git clone <https://github.com/Nathnaelgithub/expense-tracker.git>

cd expense-tracker

2️⃣ **Install dependencies**

flutter pub get

3️⃣ **Firebase setup (Required)**

This project uses environment-based Firebase configuration.

🔒 **Do NOT commit real Firebase keys**

Create your own Firebase project and generate config files:

- **Android** → android/app/google-services.json
- **iOS** → ios/Runner/GoogleService-Info.plist
- **Web** → Firebase config in index.html or via firebase_options.dart

Place them locally and keep them ignored by Git.

4️⃣ **Run the app**

flutter clean

flutter pub get

flutter run

---

## 🔐 Environment Configuration

Create an environment file:

// lib/core/config/app_env.dart

class AppEnv {
  static const bool useEmulator = true;
}

Firebase Emulator support is included for local development.

## 🧪 Firebase Emulator (Optional)

firebase emulators:start

The app automatically connects when emulator mode is enabled.

## 🚀 Future Improvements

Planned enhancements:

- ✅ Full CRUD for expenses (edit & delete)

- 👤 User profile management

- 📁 Expense categories

- 📈 Charts & analytics

- ☁️ Cloud sync & backup

- 🔐 Biometric authentication

## 📸 Screenshots

(Coming soon)

---

## 🤝 Contributing

Contributions are welcome!

 1. Fork the repository

 2. Create a feature branch

 3. Commit changes with clear messages

 4. Open a Pull Request

---

## 📄 License

This project is open-source and available under the MIT License.

---

## 👨‍💻 Author

Nathnael

Software Engineer | Flutter Developer
