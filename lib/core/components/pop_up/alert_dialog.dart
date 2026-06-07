import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:essam_shared/core/core.dart';

/// Shows an alert dialog with custom content.
///
/// This function displays a dialog with the provided [content].
/// The dialog has a rounded border radius of 12.
Future<dynamic> showAlertDialog({
  required BuildContext context,
  required Widget content,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      content: content,
    ),
  );
}

/// Shows a success dialog with optional icon and message.
///
/// This function displays a success dialog with an optional [icon],
/// [message], and navigation to a [nextScreen]. The dialog automatically
/// closes after 2 seconds and navigates to the next screen if provided.
///
/// The [removeAll] parameter controls whether to remove all routes
/// from the navigation stack when navigating to the next screen.
Future<void> showSuccessDialog(
  BuildContext context, {
  String? message,
  String? icon,
  Widget? nextScreen,
  bool removeAll = false,
}) async {
  unawaited(
    showAlertDialog(
      context: context,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Image.asset(
              icon,
              width: 40.w,
              height: 40.h,
            )
          else
            const Icon(
              Icons.check_circle,
              size: 40,
              color: Colors.green,
            ),
          SizedBox(height: 8.h),
          TextBody12(message ?? 'Success'),
        ],
      ),
    ),
  );

  await Future.delayed(const Duration(seconds: 2));

  if (!context.mounted) return;

  Navigator.pop(context);
  await Future.delayed(const Duration(milliseconds: 100));

  if (!context.mounted) return;

  if (nextScreen == null) {
    Navigator.pop(context);
    return;
  }

  final route = MaterialPageRoute(
    builder: (_) => nextScreen,
  );

  if (removeAll) {
    await Navigator.of(context).pushAndRemoveUntil(route, (_) => false);
  } else {
    await Navigator.of(context).push(route);
  }
}
