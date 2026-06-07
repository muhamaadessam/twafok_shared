import 'package:flutter/material.dart';
import 'package:essam_shared/core/core.dart';

/// A customizable text form field widget.
///
/// This widget provides a consistent text input field with customizable
/// styling, validation, and behavior. The font family can be customized
/// via the [fontFamily] parameter or globally through the app's theme.
class CustomTextFormField extends StatelessWidget {
  /// Creates a custom text form field.
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.label,
    this.validator,
    this.onChanged,
    this.isPassword = false,
    this.suffixIcon,
    this.color = Colors.black,
    this.borderRadius = 0,
    this.obscureText = false,
    this.maxLength,
    this.maxLines,
    this.hint,
    this.labelStyle,
    this.fillColor,
    this.hintStyle,
    this.borderSide,
    this.counterColor,
    this.textInputAction,
    this.prefixIcon,
    this.textColor,
    this.keyboardType,
    this.fontFamily,
  });

  /// Optional label text for the field.
  final String? label;

  /// Optional hint text to display when the field is empty.
  final String? hint;

  /// The controller for the text field.
  final TextEditingController controller;

  /// Optional validator function for the field.
  final String? Function(String?)? validator;

  /// Callback when the text changes.
  final void Function(String)? onChanged;

  /// Whether this is a password field (for backward compatibility).
  final bool? isPassword;

  /// Whether to obscure the text (for passwords).
  final bool? obscureText;

  /// Optional suffix icon widget.
  final Widget? suffixIcon;

  /// Optional prefix icon widget.
  final Widget? prefixIcon;

  /// The color for the border and icons.
  final Color? color;

  /// The fill color for the field background.
  final Color? fillColor;

  /// The color for the counter text.
  final Color? counterColor;

  /// The color for the input text.
  final Color? textColor;

  /// The border radius for the field.
  final double? borderRadius;

  /// Maximum length of the text.
  final int? maxLength;

  /// Maximum number of lines for the text.
  final int? maxLines;

  /// Style for the label text.
  final TextStyle? labelStyle;

  /// Style for the hint text.
  final TextStyle? hintStyle;

  /// Style for the border.
  final BorderSide? borderSide;

  /// The text input action (e.g., next, done).
  final TextInputAction? textInputAction;

  /// The keyboard type for the field.
  final TextInputType? keyboardType;

  /// The font family to use. If null, uses the theme's default font family.
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: color,
      maxLength: maxLength,
      maxLines: maxLines,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      style: TextStyle(
        fontFamily: fontFamily,
        color: textColor,
      ),
      decoration: InputDecoration(
        counterStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
          color: counterColor,
          fontFamily: fontFamily,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        fillColor: fillColor,
        filled: fillColor == null ? false : true,
        hintText: hint,
        labelText: label,
        labelStyle: labelStyle ??
            TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: const Color(0xffd8d8d8),
              fontFamily: fontFamily,
            ),
        hintStyle: hintStyle ??
            TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: const Color(0xffd8d8d8),
              fontFamily: fontFamily,
            ),
        errorStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
          color: context.errorColor,
          fontFamily: fontFamily,
        ),
        floatingLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
          color: color,
          fontFamily: fontFamily,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: borderSide ?? BorderSide(color: color!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: borderSide ?? BorderSide(color: color!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: borderSide ?? BorderSide(color: color!),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: BorderSide(color: AppColors.errorColor),
        ),
        suffixIconColor: color,
        prefixIconColor: color,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      obscureText: obscureText!,
    );
  }
}
