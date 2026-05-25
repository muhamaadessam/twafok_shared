import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core.dart';

class UnauthorizedScreen extends StatelessWidget {
  final VoidCallback onLogin;
  final String? title;
  final String? description;
  final String? textButton;
  final String? assetImage;
  final Color? color;

  const UnauthorizedScreen({
    super.key,
    required this.onLogin,
    this.title,
    this.description,
    this.textButton,
    this.assetImage,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorScreen(
      color: color ?? AppColors.errorColor,
      assetImage: assetImage,
      title: title ?? 'Session Expired',
      description: description ??
          'Your session has expired or you are not logged in. Please login again to continue using the app.',
      textButton: textButton ?? 'Go To Login',
      onTap: onLogin,
    );
  }
}
