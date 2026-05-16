# Twafok Shared

![Version](https://img.shields.io/badge/version-1.0.1%2B2-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.0.0+-02569B)
![Dart](https://img.shields.io/badge/Dart-3.0.0+-0175C2)
![License](https://img.shields.io/badge/license-MIT-green)

A shared Flutter package containing widgets, utilities, and unified themes for Twafok projects. This package provides a complete infrastructure for application development with ready-to-use tools.

## 📋 Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

### 🎨 Ready-to-use Components
- **Shared Widgets**: A collection of reusable widgets
- **Unified Themes**: Consistent design system across all applications
- **Ready Components**: Buttons, input fields, cards, and more

### 🔧 Utilities
- **Network Management**: Integration with Dio for API request management
- **State Management**: Support for Flutter Bloc
- **Local Storage**: SharedPreferences integration
- **Connection Checking**: Internet connection monitoring

### 🔔 Notifications
- **Firebase Cloud Messaging**: Full support for cloud notifications
- **Local Notifications**: Advanced local notification system
- **Android & iOS Integration**: Ready-to-use configurations for both platforms

### 🛠️ Additional Tools
- **Error Handling**: Integrated error management system
- **Form Validation**: Data validation tools
- **File Picker**: File selection support
- **Update Checking**: new_version_plus support

## 📦 Requirements

- **Dart**: >=3.0.0 <4.0.0
- **Flutter**: >=3.0.0
- **Android**: minSdkVersion 21
- **iOS**: iOS 10.0+

## 🚀 Installation

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  twafok_shared: ^1.0.1+2
```

Then run:

```bash
flutter pub get
```

## 💻 Usage

### Basic Initialization

```dart
import 'package:twafok_shared/twafok_shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize notifications
  await TwafokConfig.initializeNotifications();
  
  runApp(MyApp());
}
```

### Using Widgets

```dart
import 'package:twafok_shared/core/components/widgets/custom_button.dart';

CustomButton(
  text: 'Click here',
  onPressed: () {
    // Button logic
  },
)
```

### Using Network Management

```dart
import 'package:twafok_shared/core/network/remote/dio_helper.dart';

final response = await DioHelper.postData(
  url: '/api/endpoint',
  data: {'key': 'value'},
);
```

### Using Notifications

```dart
import 'package:twafok_shared/core/notifications/firebase_notification_helper.dart';

await FirebaseNotificationHelper.showNotification(
  title: 'Notification Title',
  body: 'Notification Body',
);
```

## ⚙️ Configuration

### Push Notifications Configuration (Android & iOS)

This project uses Firebase and local notifications. Add the following configuration snippets to your Android and iOS projects. Keep filenames shown in `backticks`.

#### 1) AndroidManifest (Permissions & Metadata)

Add these lines inside your `android/app/src/main/AndroidManifest.xml` as needed:

```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

<meta-data android:name="com.google.firebase.messaging.default_notification_channel_id"
android:value="high_importance_channel" />

<meta-data android:name="com.google.firebase.messaging.default_notification_icon"
android:resource="@drawable/ic_notification" />
```

#### 2) iOS Info.plist Keys

Add these keys to your iOS `Info.plist`:

```xml
<key>FirebaseAppDelegateProxyEnabled</key><true />

<key>UIBackgroundModes</key><array>
<string>remote-notification</string>
</array>
```

#### 3) Android Gradle `android {}` Configuration

Inside your app-level Gradle `android {}` block (usually `android/app/build.gradle` or `android/build.gradle` depending on your setup), add Java/Kotlin compatibility and desugaring options:

```groovy
android {
    compileSdkVersion flutter.compileSdkVersion

    defaultConfig {
        minSdkVersion 21
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
        coreLibraryDesugaringEnabled true
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }
}

dependencies {
    coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:2.1.4'
}
```

#### 4) Notification Icon

Create a notification icon using the Android Asset Studio (example link):
https://romannurik.github.io/AndroidAssetStudio/icons-notification.html

Place the generated icon in your Android project, for example:

```
android/app/src/main/res/drawable/ic_notification.png
```

#### 5) iOS `AppDelegate.swift` Example

If your iOS app uses Swift and Flutter, update `ios/Runner/AppDelegate.swift` to include Firebase and flutter_local_notifications setup. Example:

```swift
import UIKit
import Flutter
// Add the following lines
import FirebaseCore
import flutter_local_notifications
//To here

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
	_ application: UIApplication,
	didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  // Add the following lines
  FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
	 GeneratedPluginRegistrant.register(with: registry)
   }

	if #available(iOS 10.0, *) {
	  UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
	}
  //To here

	GeneratedPluginRegistrant.register(with: self)
	return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

#### 6) Final Steps (Run these commands in your project root)

```bash
flutter clean
flutter pub get
flutter run
```

**Notes:**

- Make sure you have configured Firebase for both Android and iOS (google-services.json and GoogleService-Info.plist).
- If your project is Kotlin-based ensure `kotlinOptions` is present as shown. If you don't use Kotlin, the `kotlinOptions` block can be omitted.
- Adjust `minSdkVersion` if your project requires a different minimum SDK.

### Tagging

```bash
git tag v1.0.1+8
git push --tags
```

## 📁 Project Structure

```
lib/
├── config/              # App configurations
│   ├── config.dart
│   ├── dio_config.dart
│   └── twafok_config.dart
├── core/                # Core functionality
│   ├── base/           # Base classes
│   ├── components/     # Reusable components
│   ├── constants/      # Constants
│   ├── error/          # Error handling
│   ├── extensions/     # Extensions
│   ├── network/        # Network management
│   ├── notifications/  # Notifications
│   └── use_cases/      # Use cases
├── packages/           # External packages
└── src/               # Main sources
```

## 🤝 Contributing

We welcome contributions! If you'd like to contribute to this project, please follow these steps:

1. Fork the project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

If you encounter any issues or have questions, please:
- Open an issue on GitHub
- Contact the development team

## 🔗 Useful Links

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Firebase Documentation](https://firebase.google.com/docs)

---

Made with ❤️ by the Twafok Team
