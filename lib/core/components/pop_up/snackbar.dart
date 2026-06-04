import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:essam_shared/core/core.dart';

void errorGetSnackBar(BuildContext context,
    {required String title, String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.red,
      content: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.report_rounded,
                size: 24.r,
                color: Colors.white,
              ),
              8.horizontalSpace,
              Expanded(
                child: TextTitle(
                  title,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
          if (message != null) TextBody12(message, color: Colors.white),
        ],
      ),
    ),
  );
}
