import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:twafok_shared/core/core.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateScreen extends StatelessWidget {
  final String? imageUrl;
  final String? assetImage;
  final String? playStoreUrl;
  final String? appStoreUrl;

  const ForceUpdateScreen({
    super.key,
    this.imageUrl,
    this.assetImage,
    this.playStoreUrl,
    this.appStoreUrl,
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
          padding: const EdgeInsets.all(24),
          child: Column(

            children: [
              SizedBox(width: double.infinity),
              const Spacer(),
              if (assetImage != null)
                Image.asset(
                  assetImage!,
                  width: 300.w,
                )
              else if (imageUrl != null)
                CustomNetworkImage(
                  image: imageUrl!,
                )
              else
                const Icon(
                  Icons.system_update_alt_rounded,
                  size: 100,
                ),

              const SizedBox(height: 32),

              const TextTitle(
                'A new update is available',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              const TextBody14(
                'Please update the app to continue using all features.',
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              CustomButton(
                onPressed: _launchStore,
                child: const TextTitle('Update'),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
