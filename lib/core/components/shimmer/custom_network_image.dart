import 'package:flutter/material.dart';
import 'package:essam_shared/core/core.dart';

/// A network image widget with loading shimmer and error handling.
///
/// This widget displays an image from a network URL with a loading shimmer
/// placeholder and a fallback image on error. The placeholder images can be
/// customized via the [userPlaceholder] and [defaultPlaceholder] parameters.
class CustomNetworkImage extends StatelessWidget {
  /// Creates a custom network image widget.
  const CustomNetworkImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.alignment = Alignment.center,
    this.fit,
    this.isUserImage = false,
    this.userPlaceholder,
    this.defaultPlaceholder,
  });

  /// The URL of the image to load.
  final String image;

  /// The height of the image.
  final double? height;

  /// The width of the image.
  final double? width;

  /// The alignment of the image within its bounds.
  final AlignmentGeometry alignment;

  /// How to inscribe the image into the space allocated during layout.
  final BoxFit? fit;

  /// Whether this is a user image (for selecting the appropriate placeholder).
  final bool isUserImage;

  /// Custom placeholder image path for user images.
  /// If null, uses the default user placeholder.
  final String? userPlaceholder;

  /// Custom placeholder image path for default images.
  /// If null, uses the default placeholder.
  final String? defaultPlaceholder;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      height: height,
      width: width,
      fit: BoxFit.cover,
      alignment: alignment,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return CustomShimmer(
          width: width ?? 0,
          height: height ?? 0,
          radius: 0,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        final placeholderPath = isUserImage
            ? (userPlaceholder ?? 'assets/images/imageUserPlaceholder.png')
            : (defaultPlaceholder ?? 'assets/images/imagePlaceholder.png');
        return Image.asset(
          placeholderPath,
          width: width,
          height: height,
          fit: fit,
          alignment: Alignment.center,
        );
      },
    );
  }
}
