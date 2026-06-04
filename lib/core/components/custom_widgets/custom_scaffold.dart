import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:essam_shared/core/core.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.backgroundColor,
    this.floatingActionButtonLocation,
    this.drawer,
    this.bottomNavigationBar,
    this.appBar,
  });

  final Widget body;
  final Color? backgroundColor;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  var isDeviceConnected = false;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  Future<void> initConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    if (!mounted) return;
    return _updateConnectionStatus(results);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    if (!results.contains(ConnectivityResult.none)) {
      final isConnect = await _hasActualInternet();
      if (mounted) setState(() => isDeviceConnected = isConnect);
    } else {
      if (mounted) setState(() => isDeviceConnected = false);
    }
  }

  /// Replaces InternetConnectionChecker — does a raw TCP connect to
  /// 1.1.1.1:80 (Cloudflare DNS-over-HTTPS) with a 5-second timeout.
  /// Works on iOS, Android, macOS, and other platforms without any
  /// platform-specific entitlements beyond normal internet access.
  Future<bool> _hasActualInternet() async {
    try {
      final socket = await Socket.connect(
        '1.1.1.1',
        80,
        timeout: const Duration(seconds: 5),
      );
      socket.destroy();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: !isDeviceConnected
          ? Scaffold(
              body: FutureBuilder(
                future: Future.delayed(const Duration(seconds: 1)),
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.done) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.signal_wifi_connected_no_internet_4_rounded,
                          size: 200,
                        ),
                        const Center(
                          child: TextTitle(
                            'الجهاز غير متصل بالانترنت',
                            color: Color(0xffc2c2c2),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            )
          : Scaffold(
              backgroundColor: widget.backgroundColor,
              floatingActionButtonLocation: widget.floatingActionButtonLocation,
              floatingActionButton: widget.floatingActionButton,
              drawer: widget.drawer,
              bottomNavigationBar: widget.bottomNavigationBar,
              body: widget.body,
              appBar: widget.appBar,
            ),
    );
  }
}
