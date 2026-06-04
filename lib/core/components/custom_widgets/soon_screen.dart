import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:essam_shared/core/core.dart';

class SoonScreen extends StatelessWidget {
  final String? imageUrl;
  final String? assetImage;

  const SoonScreen({
    super.key,
    this.imageUrl,
    this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        if (assetImage != null)
          Center(
            child: Image.asset(
              assetImage!,
              width: 300.w,
              fit: BoxFit.contain,
            ),
          )
        else if (imageUrl != null)
          Center(
            child: CustomNetworkImage(
              image: imageUrl!,
              width: 300.w,
            ),
          )
        else
          const Icon(
            Icons.warning_amber_rounded,
            size: 100,
          ),
        const SizedBox(height: 20),
        const Center(
          child: TextTitle(
            'Something awesome is coming ✨',
            color: Color(0xffc2c2c2),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
