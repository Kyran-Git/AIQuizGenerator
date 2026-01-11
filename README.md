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
- Windows Developer Mode
  - Go to Settings
  - Go to System
  - Go to Advanced and scroll down until Developer mode
  - Enable Developer mode

Optional enables (run once on your machine):

```bash
flutter config --enable-web
flutter config --enable-windows-desktop
```

### Project layout

The Flutter app is inside `ai_quiz_generator/`:

- `lib/` — your Dart source code (start in `lib/main.dart`)
- `test/` — unit and widget tests
- `pubspec.yaml` — app metadata, dependencies, assets, and fonts
- `android/`, `ios/`, `web/`, `windows/`, `macos/`, `linux/` — platform runners

Suggested structure as the app grows:

- `lib/screens/` — screens/pages
- `lib/widgets/` — reusable widgets
- `lib/services/` — API/services
- `lib/models/` — data models
- `assets/` — images, JSON, etc. (declare in `pubspec.yaml`)

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

### Assets and fonts

Place assets under `ai_quiz_generator/assets/` (create it if it doesn’t exist) and declare them in `pubspec.yaml`:

```yaml
flutter:
	uses-material-design: true
	assets:
		- assets/images/
		- assets/data/
```

Then run:

```bash
flutter pub get
```

### Code style and linting

This project uses `flutter_lints` (configured via `analysis_options.yaml`).

- Run lints: `flutter analyze`
- Auto-fix simple issues: `dart fix --apply`
- Format code: `dart format .`

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

Have questions or want scaffolding (routes, folders, and sample screens)? Open an issue or ask, and we can add it.
