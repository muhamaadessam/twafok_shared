import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twafok/core/core.dart';

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
        Image.asset(
          icon ?? Assets.done,
          width: widthRation(context, 40),
          height: heightRation(context, 40),
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
  Get.back();
  // ✅ استنى frame كامل عشان الدايالوج يختفي الأول
  await Future.delayed(const Duration(milliseconds: 100));

  if (!context.mounted) return;

  if (nextScreen == null) {
    // Navigator.pop(context);
    Get.back();
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
