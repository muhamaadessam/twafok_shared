import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twafok_shared/core/core.dart';

class ErrorScreen extends StatelessWidget {
  final String? imageUrl;
  final String? assetImage;
  final String? title;
  final String? description;
  final String? textButton;
  final VoidCallback? onTap;
  final Color? color;

  const ErrorScreen({
    super.key,
    this.imageUrl,
    this.assetImage,
    this.title,
    this.description,
    this.textButton,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.errorColor;

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

              /// Top status icon
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: c.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: c,
                    size: 24.r,
                  ),
                ),
              ),

              const Spacer(),

              /// Main card
              Container(
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(28.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (assetImage != null)
                      Image.asset(
                        assetImage!,
                        width: 220.w,
                        fit: BoxFit.contain,
                      )
                    else if (imageUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24.r),
                        child: CustomNetworkImage(
                          image: imageUrl!,
                        ),
                      )
                    else
                      Container(
                        width: 110.r,
                        height: 110.r,
                        decoration: BoxDecoration(
                          color: c.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.warning_amber_rounded,
                          size: 56.r,
                          color: c,
                        ),
                      ),

                    SizedBox(height: 24.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: c.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Something went wrong',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: c,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 36.h),

              TextTitle(
                title ?? 'Temporary Pause',
                textAlign: TextAlign.center,
                fontSize: 26.sp,
              ),

              SizedBox(height: 12.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: TextBody14(
                  description ??
                      'The application is temporarily unavailable due to maintenance or unexpected error. Please try again later.',
                  textAlign: TextAlign.center,
                ),
              ),

              const Spacer(),

              /// Action button
              SizedBox(
                height: 58.h,
                width: double.infinity,
                child: CustomButton(
                  borderRadius: 18.r,
                  backgroundColor: c,
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
                      TextTitle(textButton ?? 'Close App'),
                    ],
                  ),
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