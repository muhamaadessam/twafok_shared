<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart

const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.

### Tagging

```bash
git tag v1.0.1+8
git push --tags
```

## Push notifications configuration (Android & iOS)

This project uses Firebase and local notifications. Add the following configuration snippets to your
Android and iOS projects. Keep filenames shown in `backticks`.

1) AndroidManifest (permissions & metadata)

Add these lines inside your `android/app/src/main/AndroidManifest.xml` as needed:

```xml

<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

<meta-data android:name="com.google.firebase.messaging.default_notification_channel_id"
android:value="high_importance_channel" />

<meta-data android:name="com.google.firebase.messaging.default_notification_icon"
android:resource="@drawable/ic_notification" />
```

2) iOS Info.plist keys

Add these keys to your iOS `Info.plist`:

```xml

<key>FirebaseAppDelegateProxyEnabled</key><true />

<key>UIBackgroundModes</key><array>
<string>remote-notification</string>
</array>
```

3) Android Gradle `android {}` configuration

Inside your app-level Gradle `android {}` block (usually `android/app/build.gradle` or
`android/build.gradle` depending on your setup), add Java/Kotlin compatibility and desugaring
options:

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

4) Notification icon

Create a notification icon using the Android Asset Studio (example link):
https://romannurik.github.io/AndroidAssetStudio/icons-notification.html

Place the generated icon in your Android project, for example:

```
android/app/src/main/res/drawable/ic_notification.png
```

5) iOS `AppDelegate.swift` example

If your iOS app uses Swift and Flutter, update `ios/Runner/AppDelegate.swift` to include Firebase
and flutter_local_notifications setup. Example:

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

6) Final steps (run these commands in your project root)

```bash
flutter clean
flutter pub get
flutter run
```

Notes:

- Make sure you have configured Firebase for both Android and iOS (google-services.json and
  GoogleService-Info.plist).
- If your project is Kotlin-based ensure `kotlinOptions` is present as shown. If you don't use
  Kotlin, the `kotlinOptions` block can be omitted.
- Adjust `minSdkVersion` if your project requires a different minimum SDK.
