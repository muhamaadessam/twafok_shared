import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:essam_shared/core/core.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateScreen extends StatelessWidget {
  final String? imageUrl;
  final String? assetImage;
  final String? title;
  final String? description;
  final String? updateDescription;
  final String? iosTextButton;
  final String? androidTextButton;
  final String? forceUpdateText;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final Color? color;

  const ForceUpdateScreen({
    super.key,
    this.imageUrl,
    this.assetImage,
    this.title,
    this.description,
    this.updateDescription,
    this.iosTextButton,
    this.androidTextButton,
    this.forceUpdateText,
    this.playStoreUrl,
    this.appStoreUrl,
    this.color,
  });

  Future<void> _launchStore() async {
    final String? url = Platform.isAndroid
        ? playStoreUrl
        : Platform.isIOS
            ? appStoreUrl
            : null;

    if (url == null || url.isEmpty) return;

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

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
              const Spacer(),
              Container(
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
                child: assetImage != null
                    ? Image.asset(
                        assetImage!,
                        width: 240.w,
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
                              color: (color ?? context.mainColor)
                                  .withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.system_update_alt_rounded,
                              size: 60.r,
                              color: color ?? context.mainColor,
                            ),
                          ),
              ),
              SizedBox(height: 42.h),
              TextTitle(
                title ?? 'Update Required',
                textAlign: TextAlign.center,
                fontSize: 28.sp,
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: TextBody14(
                  description ??
                      'A new version of the application is available. Please update now to continue using all features and enjoy the latest improvements.',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 36.h),
              Container(
                padding: EdgeInsets.all(18.r),
                decoration: BoxDecoration(
                  color: (color ?? context.mainColor).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: color ?? context.mainColor,
                      size: 22.r,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextBody14(
                        updateDescription ??
                            'This update includes performance improvements, bug fixes and a better experience.',
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 58.h,
                width: double.infinity,
                child: CustomButton(
                  borderRadius: 18.r,
                  onPressed: _launchStore,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Platform.isIOS
                            ? Icons.apple_rounded
                            : Icons.shop_2_rounded,
                        color: Colors.white,
                        size: 22.r,
                      ),
                      SizedBox(width: 10.w),
                      TextTitle(
                        Platform.isIOS ? iosTextButton??'Open App Store' : androidTextButton??'Open Play Store',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              TextDescription(
                forceUpdateText ?? 'You must update the app to continue.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }
}
