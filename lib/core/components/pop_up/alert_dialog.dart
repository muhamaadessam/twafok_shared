import 'package:flutter/material.dart';
import 'package:twafok_shared/core/core.dart';

Future<dynamic> showAlertDialog(
    {required BuildContext context, required Widget content}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      content: content,
    ),
  );
}

Future<void> showSuccessDialog(
  BuildContext context, {
  String? message,
  String? icon,
  Widget? nextScreen,
  bool removeAll = false, // 👈 control navigation behavior
}) async {
  await showAlertDialog(
    context: context,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Image.asset(
            icon,
            width: widthRation(context, 40),
            height: heightRation(context, 40),
          )
        else
          Icon(
            Icons.check_circle,
            size: 40,
            color: Colors.green,
          ),
        SizedBox(height: heightRation(context, 8)),
        TextBody12(message ?? 'تم إرسال طلبك'),
      ],
    ),
  );

  await Future.delayed(const Duration(seconds: 2));

  if (!context.mounted) return;

  // ✅ قفل الدايالوج الأول
  // Navigator.of(context, rootNavigator: true).pop();
  Navigator.pop(context);
  // ✅ استنى frame كامل عشان الدايالوج يختفي الأول
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
