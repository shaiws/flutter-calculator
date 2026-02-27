# 🧮 Flutter Calculator

A clean, minimal calculator app built with Flutter — inspired by the iOS calculator design.

## Features

- Basic arithmetic: addition, subtraction, multiplication, division
- Percentage calculation
- Sign toggle (+/-)
- Backspace / delete last digit
- Expression history shown above the display
- Responsive layout that works on mobile and web
- Dark theme with orange operator buttons

## Screenshots

> Coming soon

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x or higher)
- Android Studio / Xcode (for mobile builds)
- A connected device or emulator

### Run the app

```bash
git clone https://github.com/shaiws/flutter-calculator.git
cd flutter-calculator
flutter pub get
flutter run
```

### Build APK

```bash
flutter build apk --release
```

### Build for Web

```bash
flutter build web --release
```

## Tech Stack

- **Flutter** — cross-platform UI framework
- **Dart** — language
- Pure Flutter widgets, no external dependencies

## Project Structure

```
lib/
└── main.dart       # Full app — UI + calculator logic
web/                # Web build assets
android/            # Android project files
```

## How It Works

State is managed with a simple `StatefulWidget`. Each button press updates the display string and tracks the current operator and first operand. The `=` button resolves the expression and updates the display with the result.

## License

MIT
