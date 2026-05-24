import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twafok_shared/core/core.dart';

class ForcePauseScreen extends StatelessWidget {
  final String? imageUrl;
  final String? assetImage;
  final String? title;
  final String? description;
  final VoidCallback? onTap;

  const ForcePauseScreen({
    super.key,
    this.imageUrl,
    this.assetImage,
    this.title,
    this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 20.h,
          ),
          child: Column(
            children: [
              SizedBox(width: double.infinity),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.pause_circle_outline_rounded,
                    color: Colors.orange,
                    size: 24.r,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.all(22.r),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(28.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
                child: assetImage != null
                    ? Image.asset(
                        assetImage!,
                        width: 250.w,
                        fit: BoxFit.contain,
                      )
                    : imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(24.r),
                            child: CustomNetworkImage(
                              image: imageUrl!,
                            ),
                          )
                        : Container(
                            width: 120.r,
                            height: 120.r,
                            decoration: BoxDecoration(
                              color: Colors.orange.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.warning_amber_rounded,
                              size: 60.r,
                              color: Colors.orange,
                            ),
                          ),
              ),
              SizedBox(height: 40.h),
              TextTitle(
                title ?? 'Temporary Pause',
                textAlign: TextAlign.center,
                fontSize: 26.sp,
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: TextBody14(
                  description ??
                      'The application is temporarily unavailable due to maintenance or updates. Please try again later.',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 36.h),
              Container(
                padding: EdgeInsets.all(18.r),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha:0.08),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Colors.orange,
                      size: 22.r,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextBody14(
                        'We are working to improve your experience and will be back shortly.',
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                borderRadius: 18.r,
                onPressed: onTap ?? () => SystemNavigator.pop(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.exit_to_app_rounded,
                      size: 22.r,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10.w),
                    const TextTitle('Close App'),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
