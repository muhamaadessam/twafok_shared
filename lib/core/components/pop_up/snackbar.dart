import 'package:flutter/material.dart';
import 'package:twafok_shared/core/core.dart';

void errorGetSnackBar(context, {required String title, String? message}) {
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
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(
                width: 8,
              ),
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
