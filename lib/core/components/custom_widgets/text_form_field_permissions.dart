import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:essam_shared/core/core.dart';

/// A text form field with permission-based styling.
///
/// This widget provides a text input field with customizable styling
/// and validation. The font family can be customized via the [fontFamily]
/// parameter or globally through the app's theme.
class TextFormFieldPermissions extends StatelessWidget {
  /// Creates a text form field with permission-based styling.
  const TextFormFieldPermissions({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.validatorMessage,
    this.suffixIcon,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.fontFamily,
  });

  /// The controller for the text field.
  final TextEditingController controller;

  /// The hint text to display when the field is empty.
  final String hintText;

  /// Maximum number of lines for the text.
  final int? maxLines;

  /// The validation error message.
  final String? validatorMessage;

  /// Optional suffix icon asset path.
  final String? suffixIcon;

  /// The keyboard type for the field.
  final TextInputType? keyboardType;

  /// Whether the field is read-only.
  final bool readOnly;

  /// Callback when the field is tapped.
  final void Function()? onTap;

  /// The font family to use. If null, uses the theme's default font family.
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        style: TextStyle(
          color: context.reverseTextColor,
          fontSize: 14,
          fontFamily: fontFamily,
        ),
        validator: (value) {
          if (value!.isEmpty && validatorMessage != null) {
            return validatorMessage;
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: suffixIcon != null
                ? Image.asset(
                    suffixIcon!,
                    width: 14.w,
                    height: 14.w,
                  )
                : null,
          ),
          helperStyle: TextStyle(
            color: context.reverseTextColor,
            fontSize: 14,
            fontFamily: fontFamily,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: context.reverseTextColor,
            fontSize: 14,
            fontFamily: fontFamily,
          ),
          errorStyle: TextStyle(
            color: context.errorColor,
            fontSize: 12,
            fontFamily: fontFamily,
          ),
          filled: true,
          fillColor: context.appBarColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
    );
  }
}
