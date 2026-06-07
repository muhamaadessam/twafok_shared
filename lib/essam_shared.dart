/// Essam Shared - A reusable Flutter design system and component library.
///
/// This package provides ready-to-use widgets, utilities, and infrastructure
/// for Flutter applications following clean architecture principles.
///
/// ## Initialization
///
/// Before using any components, initialize the package:
///
/// ```dart
/// await EssamShared.initialize(
///   config: EssamSharedConfig(
///     baseUrl: 'https://api.example.com',
///     primaryColor: Colors.blue,
///   ),
/// );
/// ```
library;

export 'config/config.dart';
export 'core/core.dart';
