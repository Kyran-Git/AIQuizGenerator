# AIQuizGenerator

An AI Quiz Generator Application built using Flutter.

## How to run

The Flutter project lives in the `ai_quiz_generator/` subfolder. From a fresh clone:

1. Open a terminal in the repo root
2. Change into the app folder
3. Fetch dependencies
4. Run on your preferred device/target

```bash
cd ai_quiz_generator
flutter pub get
flutter run
```

Notes:

- Requires a recent Flutter SDK that includes Dart >= 3.9.2 (per `environment.sdk` in `ai_quiz_generator/pubspec.yaml`).
- You can run on Android/iOS (with proper toolchains), Web (Chrome), desktop (Windows/macOS/Linux) depending on your setup.

## Development Guide

### Prerequisites

- Flutter SDK (stable channel) with Dart >= 3.9.2
- Platform toolchains as needed:
  - Android: Android Studio, Android SDK, an emulator or device
  - iOS/macOS: Xcode, CocoaPods, a simulator or device (macOS only)
  - Web: Chrome (default) or another supported browser
  - Desktop: enable the target with Flutter config if needed

Optional enables (run once on your machine):

```bash
flutter config --enable-web
flutter config --enable-windows-desktop
```

### Project layout

Repo root:

- `ai_quiz_generator/` — the Flutter app (everything below lives here)
- `LICENSE`, `README.md`

Inside `ai_quiz_generator/`:

- `lib/` — Dart source (entry: `lib/main.dart`)
  - `constants/` — app constants and config
  - `controller/` — controllers for AI/auth/exam flows
  - `data/` — models and services
  - `screen/` — UI screens (home, exam, auth)
  - `theme/` — theming
  - `util/` — helpers
  - `widgets/` — reusable UI components
- `backend/` — Python scripts and deps for DB setup/verification
- `test/` — widget tests
- `pubspec.yaml` — app metadata, dependencies, assets, fonts
- `android/`, `ios/`, `web/`, `windows/`, `macos/`, `linux/` — platform runners

### Day-to-day commands

From the repo root, step into the app folder first:

```bash
cd ai_quiz_generator
```

- Install deps: `flutter pub get`
- Run on a device: `flutter run` (add `-d <deviceId>` to target a specific device)
- List devices: `flutter devices`
- Hot reload: save files while running; press `r` in the running terminal for a manual reload
- Hot restart: press `R` in the running terminal
- Analyze (lints): `flutter analyze`
- Format: `dart format .`
- Tests: `flutter test`

### Managing dependencies

- Add: `flutter pub add <package>`
- Upgrade: `flutter pub upgrade`
- Outdated report: `flutter pub outdated`

### Testing

- Run all tests: `flutter test`
- Run a single test file: `flutter test test/widget_test.dart`

### Platform notes

- Android: ensure an emulator or device is connected; accept licenses via `flutter doctor --android-licenses`
- iOS/macOS: requires Xcode on macOS; run `cd ios && pod install` if CocoaPods are needed (managed by Flutter for most cases)
- Web: default runs on Chrome; use `-d chrome`
- Windows: ensure desktop is enabled and the Visual Studio workload for C++ Desktop is installed

### Troubleshooting

- Verify setup: `flutter doctor -v`
- Clean and rebuild: `flutter clean && flutter pub get`
- If you see SDK constraint errors, update your Flutter SDK to a version that includes Dart >= 3.9.2

---
