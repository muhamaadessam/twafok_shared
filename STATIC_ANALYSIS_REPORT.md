# Repository-Wide Static Analysis Report

**Date**: June 7, 2026  
**Package**: essam_shared  
**Version**: 1.0.1+17  
**Analysis Type**: Dependency Graph & Static Code Analysis

---

## Executive Summary

This report provides a comprehensive static analysis of the Essam Shared Flutter package, identifying dead code, unused files, unused exports, unused packages, and potential duplicates. The analysis was performed by examining all 54 Dart files in the repository and verifying actual references across the entire codebase.

### Key Findings
- **2 dead code files** identified
- **4 unused packages** in pubspec.yaml
- **1 broken export** detected
- **0 duplicate widgets/services/extensions/models** found
- **0 duplicate helper methods** found
- **0 duplicate constants** found

---

## 1. Dead Code

### 1.1 Dead Code Files

#### File: `lib/packages/dartz.dart`
- **Status**: DEAD CODE
- **Content**: Contains only a commented export: `// export 'package:dartz/dartz.dart';`
- **Reason**: The dartz package is not actually used anywhere in the codebase
- **Impact**: Low (file is small, 1 line)
- **Recommendation**: DELETE this file
- **Action Required**: Delete file and remove export from `lib/packages/packages.dart`

#### File: `lib/src/essam_shared_base.dart`
- **Status**: INTENTIONALLY EMPTY
- **Content**: Contains only comments indicating the file is intentionally empty
- **Reason**: Placeholder file that serves no purpose after refactoring
- **Impact**: Low (file is small, 3 lines)
- **Recommendation**: DELETE this file
- **Action Required**: Delete file (no references exist)

---

## 2. Unused Files

### 2.1 Analysis Results

**No unused files detected** - All 54 Dart files in the repository are either:
- Exported through barrel files (`core.dart`, `config.dart`, `design_system.dart`, `essam_shared.dart`)
- Referenced by other files through imports
- Part of the package's public API

---

## 3. Unused Exports

### 3.1 Broken Exports

#### Export: `lib/packages/packages.dart` → `dartz.dart`
- **Status**: BROKEN EXPORT
- **Issue**: Exports `dartz.dart` which contains only a commented export
- **Impact**: Medium (could cause confusion for users)
- **Recommendation**: Remove the export of `dartz.dart` from `packages.dart`
- **Action Required**: 
  ```dart
  // Before
  export 'dartz.dart';
  export 'equatable.dart';
  
  // After
  export 'equatable.dart';
  ```

### 3.2 Unused Exports in Barrel Files

**No unused exports detected** - All exports in barrel files are referenced by other files or are part of the public API.

---

## 4. Unused Packages

### 4.1 Packages Listed in pubspec.yaml but Not Imported

#### Package: `flutter_speed_dial` (^7.0.0)
- **Status**: UNUSED
- **Search Results**: No imports found in any Dart file
- **Impact**: Low (adds to package size, no functional impact)
- **Recommendation**: REMOVE from pubspec.yaml
- **Action Required**: Delete from dependencies section

#### Package: `url_launcher_ios` (^6.2.4)
- **Status**: UNUSED
- **Search Results**: No imports found in any Dart file
- **Note**: The package uses `url_launcher` (^6.3.2) instead
- **Impact**: Low (platform-specific package not needed)
- **Recommendation**: REMOVE from pubspec.yaml
- **Action Required**: Delete from dependencies section

#### Package: `internet_connection_checker` (^3.0.1)
- **Status**: UNUSED
- **Search Results**: No imports found in any Dart file
- **Note**: The package uses `connectivity_plus` for connectivity checking
- **Impact**: Low (adds to package size)
- **Recommendation**: REMOVE from pubspec.yaml
- **Action Required**: Delete from dependencies section

#### Package: `flutter_svg` (^2.0.9)
- **Status**: UNUSED
- **Search Results**: No imports found in any Dart file
- **Impact**: Low (adds to package size)
- **Recommendation**: REMOVE from pubspec.yaml
- **Action Required**: Delete from dependencies section

### 4.2 Packages Used in pubspec.yaml

The following packages are actively used in the codebase:

| Package | Usage | Files |
|---------|-------|-------|
| `connectivity_plus` | Connectivity monitoring | custom_scaffold.dart |
| `dio` | HTTP client | dio_config.dart |
| `equatable` | Value equality | Multiple files (error, failure, use_case, base_bloc) |
| `file_picker` | File selection | pick_image.dart |
| `flutter_bloc` | State management | base_bloc.dart, base_view.dart, app_theme_cubit.dart |
| `flutter_screenutil` | Responsive sizing | 9 widget files |
| `flutter_spinkit` | Loading indicators | loading_view.dart |
| `flutter_local_notifications` | Local notifications | local_notification_helper.dart |
| `get_it` | Dependency injection | base_view.dart |
| `logscope_flutter` | Logging | dio_config.dart |
| `pretty_dio_logger` | HTTP logging | dio_config.dart |
| `shared_preferences` | Local storage | cache_helper.dart |
| `shimmer` | Loading effects | shimmer_widget.dart, custom_network_image.dart |
| `firebase_core` | Firebase initialization | firebase_notification_helper.dart |
| `firebase_messaging` | Push notifications | firebase_notification_helper.dart |
| `flutter_secure_storage` | Secure storage | secure_cache_helper.dart |
| `url_launcher` | URL launching | force_update_screen.dart |
| `intl` | Date formatting | app_logger.dart (DateFormat) |
| `cupertino_icons` | iOS icons | Flutter default |

### 4.3 Dev Dependencies

| Package | Status | Notes |
|---------|--------|-------|
| `very_good_analysis` | USED | Linting rules (expected dev dependency) |
| `flutter_lints` | USED | Linting rules (expected dev dependency) |
| `flutter_test` | USED | Testing framework (expected dev dependency) |

---

## 5. Duplicate Analysis

### 5.1 Duplicate Widgets

**No duplicate widgets detected**

Analysis found:
- 1 Scaffold class: `CustomScaffold` (custom_scaffold.dart)
- 1 Button class: `CustomButton` (custom_button.dart)
- 5 Screen classes: `ErrorScreen`, `ForcePauseScreen`, `ForceUpdateScreen`, `SoonScreen`, `UnauthorizedScreen` (all unique purposes)
- 4 Text classes: `TextTitle`, `TextBody14`, `TextBody12`, `TextDescription` (all unique purposes)
- 2 TextFormField classes: `CustomTextFormField`, `TextFormFieldPermissions` (different use cases)
- 2 Image classes: `CustomNetworkImage`, `CustomShimmer` (different purposes)

All widgets serve unique purposes and are not duplicates.

### 5.2 Duplicate Services

**No duplicate services detected**

Analysis found:
- `DioHelper` - HTTP client (dio_config.dart)
- `CacheHelper` - Local storage (cache_helper.dart)
- `SecureCacheHelper` - Secure storage (secure_cache_helper.dart)
- `FirebaseNotificationHelper` - Firebase notifications (firebase_notification_helper.dart)
- `LocalNotificationHelper` - Local notifications (local_notification_helper.dart)
- `AppLogger` - Logging (app_logger.dart)

All services serve unique purposes and are not duplicates.

### 5.3 Duplicate Extensions

**No duplicate extensions detected**

Analysis found:
- `ContextExtensions` - BuildContext extensions (context_extension.dart)
- `MapExtension` - Map extensions (map_extension.dart)
- `StringExtension` - String extensions (string_extension.dart)
- `SpacingExtension` - Double extensions for spacing (app_spacing.dart)
- `RadiusExtension` - Double extensions for radius (app_radius.dart)
- `TypographyExtension` - Double extensions for typography (app_typography.dart)
- `BoxShadowExtension` - List<BoxShadow> extensions (app_shadows.dart)

All extensions serve unique purposes and are not duplicates.

### 5.4 Duplicate Models

**No duplicate models detected**

Analysis found:
- `ErrorMessageModel` - Error message model (error_model.dart)
- `AppThemeState` - Theme state model (app_theme_state.dart)
- `BaseState` - Base state model (base_state.dart)
- `Result<T>` - Result type (result_helper.dart)

All models serve unique purposes and are not duplicates.

### 5.5 Duplicate Helper Methods

**No duplicate helper methods detected**

All helper methods are properly scoped within their respective classes and serve unique purposes.

### 5.6 Duplicate Constants

**No duplicate constants detected**

Analysis found:
- Design system constants in `app_colors.dart`, `app_spacing.dart`, `app_radius.dart`, `app_typography.dart`, `app_shadows.dart`
- Legacy color constants in `colors.dart` (now delegate to design system)
- Notification channel constants in `local_notification_helper.dart`

All constants serve unique purposes and are not duplicates.

---

## 6. Dependency Graph Analysis

### 6.1 Package Structure

```
essam_shared/
├── lib/
│   ├── config/
│   │   ├── config.dart (barrel)
│   │   ├── dio_config.dart
│   │   ├── essam_config.dart
│   │   └── essam_shared_config.dart
│   ├── core/
│   │   ├── base/
│   │   ├── components/
│   │   ├── constants/
│   │   ├── design_system/
│   │   ├── error/
│   │   ├── extensions/
│   │   ├── logger/
│   │   ├── network/
│   │   ├── notifications/
│   │   ├── use_cases/
│   │   └── core.dart (barrel)
│   ├── packages/
│   │   ├── packages.dart (barrel)
│   │   ├── dartz.dart (dead code)
│   │   └── equatable.dart
│   ├── src/
│   │   └── essam_shared_base.dart (empty)
│   └── essam_shared.dart (main export)
└── example/
```

### 6.2 Export Dependencies

**Main Export Chain:**
```
essam_shared.dart
├── config/config.dart
│   ├── dio_config.dart
│   ├── essam_config.dart
│   └── essam_shared_config.dart
└── core/core.dart
    ├── base/
    ├── components/
    ├── constants/
    ├── design_system/
    ├── error/
    ├── extensions/
    ├── logger/
    ├── network/
    ├── notifications/
    └── use_cases/
```

### 6.3 Import Dependencies

**High-Level Dependencies:**
- `essam_config.dart` depends on `dio_config.dart` and `core.dart`
- `dio_config.dart` depends on `essam_config.dart` and `core.dart` (circular dependency)
- `base_view.dart` depends on `config.dart` and `core.dart`
- Most widgets depend on `core.dart` (barrel export)

**Circular Dependency Detected:**
- `essam_config.dart` → `dio_config.dart` → `essam_config.dart`
- **Impact**: Medium (makes testing difficult, creates tight coupling)
- **Recommendation**: Refactor to break circular dependency by:
  - Creating a separate configuration interface
  - Using dependency injection
  - Moving shared types to a separate module

---

## 7. Code Quality Metrics

### 7.1 File Statistics

| Metric | Count |
|--------|-------|
| Total Dart Files | 54 |
| Barrel Files | 4 |
| Part Files | 2 (base_state.dart, app_theme_state.dart) |
| Empty Files | 1 (essam_shared_base.dart) |
| Dead Code Files | 1 (dartz.dart) |

### 7.2 Package Usage Statistics

| Category | Count |
|----------|-------|
| Used Dependencies | 18 |
| Unused Dependencies | 4 |
| Dev Dependencies | 3 |
| Total Dependencies | 25 |

### 7.3 Export Statistics

| Metric | Count |
|--------|-------|
| Total Exports | 51 |
| Broken Exports | 1 |
| Unused Exports | 0 |

---

## 8. Recommendations

### 8.1 High Priority (Critical)

1. **Delete dead code file: `lib/packages/dartz.dart`**
   - Remove file
   - Remove export from `lib/packages/packages.dart`

2. **Delete empty file: `lib/src/essam_shared_base.dart`**
   - Remove file (no references exist)

3. **Remove unused packages from pubspec.yaml**
   - Remove `flutter_speed_dial`
   - Remove `url_launcher_ios`
   - Remove `internet_connection_checker`
   - Remove `flutter_svg`

4. **Fix broken export in `lib/packages/packages.dart`**
   - Remove export of `dartz.dart`

### 8.2 Medium Priority (Recommended)

5. **Break circular dependency between `essam_config.dart` and `dio_config.dart`**
   - Create a configuration interface
   - Use dependency injection pattern
   - Move shared types to a separate module

6. **Consider removing `lib/packages/` directory entirely**
   - Only contains `equatable.dart` which just re-exports the package
   - Direct import of `package:equatable/equatable.dart` is clearer

### 8.3 Low Priority (Optional)

7. **Review `intl` package usage**
   - Only used in `app_logger.dart` for date formatting
   - Consider if this is necessary or if a simpler solution exists

---

## 9. Action Items Summary

### Immediate Actions Required

| Action | File | Type | Priority |
|--------|------|------|----------|
| Delete file | `lib/packages/dartz.dart` | Dead code | High |
| Delete file | `lib/src/essam_shared_base.dart` | Empty file | High |
| Remove export | `lib/packages/packages.dart` (line 1) | Broken export | High |
| Remove dependency | `pubspec.yaml` (flutter_speed_dial) | Unused package | High |
| Remove dependency | `pubspec.yaml` (url_launcher_ios) | Unused package | High |
| Remove dependency | `pubspec.yaml` (internet_connection_checker) | Unused package | High |
| Remove dependency | `pubspec.yaml` (flutter_svg) | Unused package | High |

### Recommended Actions

| Action | Description | Priority |
|--------|-------------|----------|
| Refactor circular dependency | Break essam_config ↔ dio_config cycle | Medium |
| Remove packages directory | Delete lib/packages/ entirely | Medium |
| Review intl usage | Evaluate if needed for date formatting | Low |

---

## 10. Conclusion

The Essam Shared package is in good overall condition with minimal dead code and no duplicate implementations. The main issues identified are:

1. **Dead code files** (2 files) - Easy to remove
2. **Unused packages** (4 packages) - Easy to remove
3. **Broken export** (1 export) - Easy to fix
4. **Circular dependency** (1 cycle) - Requires refactoring

All issues are straightforward to address and will improve the package's maintainability and reduce its size. No duplicate widgets, services, extensions, models, helper methods, or constants were found, indicating good code organization.

### Overall Health Score: **8/10**

The package is well-structured with minimal technical debt. Addressing the identified issues will bring it to a **9/10** health score.
