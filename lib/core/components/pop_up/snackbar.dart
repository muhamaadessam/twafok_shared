import 'package:flutter/material.dart';
import 'package:twafok/core/core.dart';

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
              Image.asset(
                Assets.alertOctagon,
                height: heightRation(context, 24),
                width: widthRation(context, 24),
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
