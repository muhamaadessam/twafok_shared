# Test Recommendations for Essam Shared Package

**Date**: June 7, 2026  
**Package**: essam_shared  
**Version**: 1.0.1+17

---

## Overview

This document provides comprehensive test recommendations for the Essam Shared package to ensure production readiness and reliability.

---

## Test Coverage Goals

- **Unit Tests**: 80%+ coverage for core utilities and helpers
- **Widget Tests**: 70%+ coverage for custom widgets
- **Integration Tests**: Critical user flows (network, storage, notifications)
- **Golden Tests**: Visual regression tests for design system

---

## Unit Test Recommendations

### 1. Design System Tests

#### File: `test/design_system/app_colors_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/design_system/design_system.dart';

void main() {
  group('AppColors', () {
    test('primary color should be defined', () {
      expect(AppColors.primary, isNotNull);
      expect(AppColors.primary, isA<Color>());
    });

    test('all colors should be immutable constants', () {
      // Verify colors are const
      expect(AppColors.primary, const Color(0xFF1E294D));
    });

    test('semantic colors should have appropriate values', () {
      expect(AppColors.success, isNotNull);
      expect(AppColors.error, isNotNull);
      expect(AppColors.warning, isNotNull);
    });

    test('theme colors should be defined', () {
      expect(AppColors.darkScaffold, isNotNull);
      expect(AppColors.lightScaffold, isNotNull);
    });
  });
}
```

#### File: `test/design_system/app_spacing_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/design_system/design_system.dart';

void main() {
  group('AppSpacing', () {
    test('base unit should be 4.0', () {
      expect(AppSpacing.unit, 4.0);
    });

    test('spacing scale should be consistent', () {
      expect(AppSpacing.xxs, AppSpacing.unit);
      expect(AppSpacing.xs, AppSpacing.unit * 2);
      expect(AppSpacing.sm, AppSpacing.unit * 3);
      expect(AppSpacing.md, AppSpacing.unit * 4);
    });

    test('common spacing values should be defined', () {
      expect(AppSpacing.cardPadding, AppSpacing.md);
      expect(AppSpacing.sectionPadding, AppSpacing.lg);
    });
  });
}
```

#### File: `test/design_system/app_radius_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/design_system/design_system.dart';

void main() {
  group('AppRadius', () {
    test('base unit should be 4.0', () {
      expect(AppRadius.unit, 4.0);
    });

    test('radius scale should be consistent', () {
      expect(AppRadius.none, 0);
      expect(AppRadius.xs, AppRadius.unit);
      expect(AppRadius.sm, AppRadius.unit * 2);
    });

    test('common radius values should be defined', () {
      expect(AppRadius.button, AppRadius.lg);
      expect(AppRadius.card, AppRadius.lg);
      expect(AppRadius.avatar, AppRadius.full);
    });
  });
}
```

#### File: `test/design_system/app_typography_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/design_system/design_system.dart';

void main() {
  group('AppTypography', () {
    test('font weights should be defined', () {
      expect(AppTypography.regular, FontWeight.w400);
      expect(AppTypography.medium, FontWeight.w500);
      expect(AppTypography.bold, FontWeight.w700);
    });

    test('font sizes should follow scale', () {
      expect(AppTypography.displayLarge, 57.0);
      expect(AppTypography.bodyMedium, 14.0);
      expect(AppTypography.labelSmall, 11.0);
    });

    test('line heights should be defined', () {
      expect(AppTypography.lineHeightTight, 1.0);
      expect(AppTypography.lineHeightNormal, 1.5);
      expect(AppTypography.lineHeightLoose, 2.0);
    });
  });
}
```

#### File: `test/design_system/app_shadows_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/design_system/design_system.dart';

void main() {
  group('AppShadows', () {
    test('none shadow should be empty', () {
      expect(AppShadows.none, isEmpty);
    });

    test('elevation shadows should be defined', () {
      expect(AppShadows.xs, hasLength(1));
      expect(AppShadows.sm, hasLength(1));
      expect(AppShadows.md, hasLength(1));
      expect(AppShadows.lg, hasLength(1));
    });

    test('colored shadows should accept color parameter', () {
      final shadows = AppShadows.primary(Colors.blue);
      expect(shadows, hasLength(1));
      expect(shadows.first.color, Colors.blue.withOpacity(0.2));
    });
  });
}
```

### 2. Configuration Tests

#### File: `test/config/essam_shared_config_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/config/essam_shared_config.dart';

void main() {
  group('EssamSharedConfig', () {
    test('should create config with default values', () {
      final config = EssamSharedConfig(
        baseUrl: 'https://api.example.com',
      );

      expect(config.baseUrl, 'https://api.example.com');
      expect(config.enableLogging, true);
      expect(config.enableAnalytics, false);
      expect(config.themeMode, ThemeMode.system);
    });

    test('should create config with custom values', () {
      final config = EssamSharedConfig(
        baseUrl: 'https://api.example.com',
        primaryColor: const Color(0xFF0000FF),
        enableLogging: false,
        themeMode: ThemeMode.dark,
      );

      expect(config.primaryColor, const Color(0xFF0000FF));
      expect(config.enableLogging, false);
      expect(config.themeMode, ThemeMode.dark);
    });

    test('copyWith should create new instance with updated values', () {
      final config1 = EssamSharedConfig(
        baseUrl: 'https://api.example.com',
      );

      final config2 = config1.copyWith(
        primaryColor: const Color(0xFF0000FF),
      );

      expect(config1.primaryColor, isNot(config2.primaryColor));
      expect(config2.primaryColor, const Color(0xFF0000FF));
      expect(config1.baseUrl, config2.baseUrl);
    });

    test('should be immutable', () {
      final config = EssamSharedConfig(
        baseUrl: 'https://api.example.com',
      );

      // Verify that config properties cannot be modified
      expect(() => config.baseUrl = 'new-url', throwsUnsupportedError);
    });
  });
}
```

#### File: `test/config/essam_shared_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/config/essam_shared_config.dart';
import 'package:essam_shared/essam_shared.dart';

void main() {
  group('EssamShared', () {
    test('should throw error when accessing config before initialization', () {
      EssamShared.reset();

      expect(
        () => EssamShared.config,
        throwsA(isA<StateError>()),
      );
    });

    test('should initialize with config', () async {
      EssamShared.reset();

      await EssamShared.initialize(
        config: EssamSharedConfig(
          baseUrl: 'https://api.example.com',
        ),
      );

      expect(EssamShared.isInitialized, true);
      expect(EssamShared.config.baseUrl, 'https://api.example.com');
    });

    test('should not reinitialize if already initialized', () async {
      EssamShared.reset();

      await EssamShared.initialize(
        config: EssamSharedConfig(
          baseUrl: 'https://api.example.com',
        ),
      );

      final firstConfig = EssamShared.config;

      await EssamShared.initialize(
        config: EssamSharedConfig(
          baseUrl: 'https://different.example.com',
        ),
      );

      expect(EssamShared.config, same(firstConfig));
    });

    test('reset should clear configuration', () async {
      await EssamShared.initialize(
        config: EssamSharedConfig(
          baseUrl: 'https://api.example.com',
        ),
      );

      EssamShared.reset();

      expect(EssamShared.isInitialized, false);
      expect(
        () => EssamShared.config,
        throwsA(isA<StateError>()),
      );
    });
  });
}
```

### 3. Extension Tests

#### File: `test/extensions/string_extension_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/extensions/string_extension.dart';

void main() {
  group('StringExtension', () {
    group('toInt', () {
      test('should convert valid string to int', () {
        expect('123'.toInt, 123);
      });

      test('should throw on invalid string', () {
        expect(() => 'abc'.toInt, throwsFormatException);
      });
    });

    group('toDouble', () {
      test('should convert valid string to double', () {
        expect('123.45'.toDouble, 123.45);
      });

      test('should throw on invalid string', () {
        expect(() => 'abc'.toDouble, throwsFormatException);
      });
    });

    group('toDateTime', () {
      test('should convert ISO string to DateTime', () {
        final date = '2024-01-01T00:00:00.000Z'.toDateTime;
        expect(date, isA<DateTime>());
      });

      test('should throw on invalid string', () {
        expect(() => 'invalid'.toDateTime, throwsFormatException);
      });
    });

    group('toUri', () {
      test('should convert valid string to Uri', () {
        final uri = 'https://example.com'.toUri;
        expect(uri, isA<Uri>());
        expect(uri.toString(), 'https://example.com');
      });

      test('should throw on invalid string', () {
        expect(() => 'not a uri'.toUri, throwsFormatException);
      });
    });

    group('numberFormat', () {
      test('should format large numbers', () {
        expect('1500'.numberFormat, '1.5k');
        expect('1500000'.numberFormat, '1.5M');
      });

      test('should handle small numbers', () {
        expect('500'.numberFormat, '500');
      });
    });
  });
}
```

#### File: `test/extensions/map_extension_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/extensions/map_extension.dart';

void main() {
  group('MapExtension', () {
    test('should reverse map entries', () {
      final map = {'a': 1, 'b': 2, 'c': 3};
      final reversed = map.reverse();

      expect(reversed, {'c': 3, 'b': 2, 'a': 1});
    });

    test('should handle empty map', () {
      final map = <String, int>{};
      final reversed = map.reverse();

      expect(reversed, isEmpty);
    });

    test('should create new map, not modify original', () {
      final map = {'a': 1, 'b': 2};
      final reversed = map.reverse();

      expect(map, {'a': 1, 'b': 2});
      expect(reversed, {'b': 2, 'a': 1});
    });
  });
}
```

### 4. Error Handling Tests

#### File: `test/error/failure_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/error/failure.dart';

void main() {
  group('Failure', () {
    test('NetworkFailure should have message', () {
      final failure = NetworkFailure('No internet');
      expect(failure.message, 'No internet');
    });

    test('ServerFailure should have status code', () {
      final failure = ServerFailure.badRequest('Invalid data');
      expect(failure.message, 'Invalid data');
    });

    test('LocalFailure should have message', () {
      final failure = LocalFailure.cache('Cache error');
      expect(failure.message, 'Cache error');
    });

    test('failures should be equatable', () {
      final failure1 = NetworkFailure('Error');
      final failure2 = NetworkFailure('Error');
      final failure3 = NetworkFailure('Different');

      expect(failure1, equals(failure2));
      expect(failure1, isNot(equals(failure3)));
    });
  });
}
```

---

## Widget Test Recommendations

### 1. Custom Widgets Tests

#### File: `test/widgets/custom_button_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/components/custom_widgets/custom_button.dart';

void main() {
  group('CustomButton', () {
    testWidgets('should render with child', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              onPressed: () {},
              child: const Text('Click Me'),
            ),
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              onPressed: () => pressed = true,
              child: const Text('Click Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(CustomButton));
      await tester.pump();

      expect(pressed, true);
    });

    testWidgets('should apply custom colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              onPressed: () {},
              backgroundColor: Colors.red,
              child: const Text('Click Me'),
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      // Verify color is applied
      expect(button, isNotNull);
    });
  });
}
```

#### File: `test/widgets/custom_text_form_field_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/components/custom_widgets/custom_text_form_field.dart';

void main() {
  group('CustomTextFormField', () {
    testWidgets('should render with label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              controller: TextEditingController(),
              label: 'Test Label',
            ),
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
    });

    testWidgets('should validate with custom validator', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              controller: controller,
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextFormField));
      await tester.enterText(find.byType(TextFormField), '');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(find.text('Required'), findsOneWidget);
    });

    testWidgets('should obscure text when obscureText is true', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomTextFormField(
              controller: TextEditingController(),
              obscureText: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.obscureText, true);
    });
  });
}
```

#### File: `test/widgets/text_title_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/constants/text.dart';

void main() {
  group('TextTitle', () {
    testWidgets('should render text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextTitle('Test Title'),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('should apply custom color', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextTitle(
              'Test Title',
              color: Colors.red,
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Test Title'));
      expect(text.style?.color, Colors.red);
    });

    testWidgets('should apply custom font size', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextTitle(
              'Test Title',
              fontSize: 20,
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Test Title'));
      expect(text.style?.fontSize, isNotNull);
    });

    testWidgets('should use theme font family when fontFamily is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(fontFamily: 'Roboto'),
          home: Scaffold(
            body: TextTitle('Test Title'),
          ),
        ),
      );

      final text = tester.widget<Text>(find.text('Test Title'));
      expect(text.style?.fontFamily, isNull); // Uses theme default
    });
  });
}
```

---

## Integration Test Recommendations

### 1. Network Layer Tests

#### File: `integration_test/network_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/config/essam_shared_config.dart';
import 'package:essam_shared/essam_shared.dart';
import 'package:essam_shared/config/dio_config.dart';

void main() {
  group('Network Integration Tests', () {
    setUpAll(() async {
      await EssamShared.initialize(
        config: EssamSharedConfig(
          baseUrl: 'https://jsonplaceholder.typicode.com',
        ),
      );
    });

    test('should make successful GET request', () async {
      final result = await DioHelper.getData('/posts/1');

      expect(result.isSuccess, true);
    });

    test('should handle network errors', () async {
      final result = await DioHelper.getData('/invalid-endpoint');

      expect(result.isSuccess, false);
    });

    test('should include authorization header when token is set', () async {
      await EssamConfig.setToken('test-token');

      final result = await DioHelper.getData('/posts/1');

      // Verify token is included in headers
      expect(result, isNotNull);
    });
  });
}
```

### 2. Storage Tests

#### File: `integration_test/storage_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/network/local/cache_helper.dart';
import 'package:essam_shared/core/network/local/secure_cache_helper.dart';

void main() {
  group('Storage Integration Tests', () {
    setUpAll(() async {
      await CacheHelper.init();
      await SecureCacheHelper.init();
    });

    test('should store and retrieve data from cache', () async {
      await CacheHelper.put('test_key', 'test_value');
      final value = CacheHelper.get('test_key');

      expect(value, 'test_value');
    });

    test('should store and retrieve data from secure cache', () async {
      await SecureCacheHelper.put(key: 'secure_key', value: 'secure_value');
      final value = await SecureCacheHelper.get('secure_key');

      expect(value, 'secure_value');
    });

    test('should clear cache data', () async {
      await CacheHelper.put('test_key', 'test_value');
      await CacheHelper.remove('test_key');
      final value = CacheHelper.get('test_key');

      expect(value, isNull);
    });

    tearDownAll(() async {
      await CacheHelper.clearData();
      await SecureCacheHelper.clearData();
    });
  });
}
```

---

## Golden Test Recommendations

### File: `test/golden/design_system_golden_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:essam_shared/core/design_system/design_system.dart';

void main() {
  group('Design System Golden Tests', () {
    testWidgets('AppColors should match golden', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Container(color: AppColors.primary, height: 50),
                Container(color: AppColors.secondary, height: 50),
                Container(color: AppColors.success, height: 50),
                Container(color: AppColors.error, height: 50),
              ],
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('goldens/app_colors.png'),
      );
    });

    testWidgets('spacing tokens should match golden', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                SizedBox(height: AppSpacing.xs),
                SizedBox(height: AppSpacing.sm),
                SizedBox(height: AppSpacing.md),
                SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(Scaffold),
        matchesGoldenFile('goldens/spacing_tokens.png'),
      );
    });
  });
}
```

---

## Test Setup Instructions

### 1. Update pubspec.yaml

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mockito: ^5.4.0
  build_runner: ^2.4.0
  golden_toolkit: ^0.15.0
  flutter_test_utils: ^2.0.0
```

### 2. Create Test Directory Structure

```
test/
├── design_system/
│   ├── app_colors_test.dart
│   ├── app_spacing_test.dart
│   ├── app_radius_test.dart
│   ├── app_typography_test.dart
│   └── app_shadows_test.dart
├── config/
│   ├── essam_shared_config_test.dart
│   └── essam_shared_test.dart
├── extensions/
│   ├── string_extension_test.dart
│   └── map_extension_test.dart
├── error/
│   └── failure_test.dart
├── widgets/
│   ├── custom_button_test.dart
│   ├── custom_text_form_field_test.dart
│   └── text_title_test.dart
├── integration/
│   ├── network_test.dart
│   └── storage_test.dart
└── golden/
    └── design_system_golden_test.dart
```

### 3. Run Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/design_system/app_colors_test.dart

# Run integration tests
flutter test integration/

# Update golden files
flutter test --update-goldens
```

---

## Test Coverage Goals

### Target Coverage by Module

| Module | Target Coverage | Priority |
|--------|----------------|----------|
| Design System | 95% | High |
| Configuration | 90% | High |
| Extensions | 85% | Medium |
| Error Handling | 85% | Medium |
| Widgets | 70% | High |
| Network Layer | 60% | High |
| Storage | 60% | High |
| Notifications | 50% | Medium |

### Overall Target

- **Unit Tests**: 80%+ coverage
- **Widget Tests**: 70%+ coverage
- **Integration Tests**: Critical paths covered
- **Golden Tests**: Design system components

---

## Continuous Integration

### Recommended CI Configuration

```yaml
# .github/workflows/test.yml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.16.0'
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test --coverage
      - run: flutter test integration/
      - uses: codecov/codecov-action@v3
```

---

## Missing Test Scenarios

### High Priority
1. **Theme switching tests** - Verify theme changes work correctly
2. **Connectivity tests** - Test offline/online transitions
3. **Token refresh tests** - Test token refresh logic
4. **Error boundary tests** - Test error handling in widgets

### Medium Priority
5. **Notification tests** - Test notification display and handling
6. **File picker tests** - Test image/file selection
7. **Form validation tests** - Test complex form scenarios
8. **Navigation tests** - Test navigation helpers

### Low Priority
9. **Performance tests** - Measure widget rendering performance
10. **Accessibility tests** - Verify accessibility compliance

---

## Conclusion

Implementing these tests will significantly improve the package's reliability and maintainability. Start with high-priority unit tests for the design system and configuration, then move to widget tests, and finally integration tests.

**Estimated Total Effort**: 2-3 weeks for full test coverage implementation.
