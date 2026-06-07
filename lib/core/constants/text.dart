import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A text widget for displaying titles with customizable styling.
///
/// This widget provides a consistent way to display title text throughout
/// the application. The font family can be customized via the [fontFamily] parameter
/// or globally through the app's theme.
class TextTitle extends StatelessWidget {
  /// Creates a title text widget.
  const TextTitle(
    this.text, {
    super.key,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.overflow,
    this.fontFamily,
  });

  /// The text to display.
  final String text;

  /// The font weight of the text.
  final FontWeight? fontWeight;

  /// The font size of the text.
  final double? fontSize;

  /// The color of the text.
  final Color? color;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The font family to use. If null, uses the theme's default font family.
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: (fontSize ?? 15).sp,
        color: color,
        fontFamily: fontFamily,
      ),
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
    );
  }
}

/// A text widget for displaying body text with 14sp default size.
///
/// This widget provides a consistent way to display body text throughout
/// the application. The font family can be customized via the [fontFamily] parameter
/// or globally through the app's theme.
class TextBody14 extends StatelessWidget {
  /// Creates a body text widget with 14sp default size.
  const TextBody14(
    this.text, {
    super.key,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.overflow,
    this.fontFamily,
  });

  /// The text to display.
  final String text;

  /// The font weight of the text.
  final FontWeight? fontWeight;

  /// The font size of the text.
  final double? fontSize;

  /// The color of the text.
  final Color? color;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The font family to use. If null, uses the theme's default font family.
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: (fontSize ?? 13).sp,
        color: color,
        fontFamily: fontFamily,
      ),
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
    );
  }
}

/// A text widget for displaying body text with 12sp default size.
///
/// This widget provides a consistent way to display body text throughout
/// the application. The font family can be customized via the [fontFamily] parameter
/// or globally through the app's theme.
class TextBody12 extends StatelessWidget {
  /// Creates a body text widget with 12sp default size.
  const TextBody12(
    this.text, {
    super.key,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.overflow,
    this.maxLines,
    this.fontFamily,
  });

  /// The text to display.
  final String text;

  /// The font weight of the text.
  final FontWeight? fontWeight;

  /// The font size of the text.
  final double? fontSize;

  /// The color of the text.
  final Color? color;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// The font family to use. If null, uses the theme's default font family.
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: (fontSize ?? 11).sp,
        color: color,
        fontFamily: fontFamily,
      ),
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

/// A text widget for displaying descriptive text.
///
/// This widget provides a consistent way to display descriptive text throughout
/// the application. The font family can be customized via the [fontFamily] parameter
/// or globally through the app's theme.
class TextDescription extends StatelessWidget {
  /// Creates a descriptive text widget.
  const TextDescription(
    this.text, {
    super.key,
    this.textAlign,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.overflow,
    this.fontFamily,
  });

  /// The text to display.
  final String text;

  /// The font weight of the text.
  final FontWeight? fontWeight;

  /// The font size of the text.
  final double? fontSize;

  /// The color of the text.
  final Color? color;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// The font family to use. If null, uses the theme's default font family.
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: (fontSize ?? 11).sp,
        color: color,
        fontFamily: fontFamily,
      ),
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
    );
  }
}
