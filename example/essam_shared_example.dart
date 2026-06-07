import 'package:flutter/material.dart';
import 'package:essam_shared/essam_shared.dart';

void main() async {
  // Initialize the package with configuration
  await EssamShared.initialize(
    config: EssamSharedConfig(
      baseUrl: 'https://api.example.com',
      primaryColor: const Color(0xFF1E294D),
    ),
  );

  // Your app code here
  print('Essam Shared package initialized successfully');
}
