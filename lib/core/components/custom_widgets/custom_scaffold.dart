import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:essam_shared/core/core.dart';

/// A scaffold widget with built-in connectivity monitoring.
///
/// This widget automatically monitors network connectivity and shows
/// a no-internet screen when the device is offline. The text direction
/// is automatically determined from the app's locale.
class CustomScaffold extends StatefulWidget {
  /// Creates a custom scaffold with connectivity monitoring.
  const CustomScaffold({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.backgroundColor,
    this.floatingActionButtonLocation,
    this.drawer,
    this.bottomNavigationBar,
    this.appBar,
    this.noInternetMessage,
    this.noInternetIcon,
  });

  /// The main body content of the scaffold.
  final Widget body;

  /// Optional background color for the scaffold.
  final Color? backgroundColor;

  /// Optional floating action button.
  final Widget? floatingActionButton;

  /// Optional floating action button location.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Optional drawer.
  final Widget? drawer;

  /// Optional bottom navigation bar.
  final Widget? bottomNavigationBar;

  /// Optional app bar.
  final PreferredSizeWidget? appBar;

  /// Custom message to show when no internet connection.
  /// If null, a default message will be used.
  final String? noInternetMessage;

  /// Custom icon to show when no internet connection.
  /// If null, a default icon will be used.
  final IconData? noInternetIcon;

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

  /// Checks for actual internet connectivity by connecting to Cloudflare DNS.
  ///
  /// This performs a raw TCP connect to 1.1.1.1:80 with a 5-second timeout.
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
    return !isDeviceConnected
        ? Scaffold(
            body: FutureBuilder(
              future: Future.delayed(const Duration(seconds: 1)),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.done) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        widget.noInternetIcon ??
                            Icons.signal_wifi_connected_no_internet_4_rounded,
                        size: 200,
                        color: const Color(0xffc2c2c2),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: TextTitle(
                          widget.noInternetMessage ?? 'No Internet Connection',
                          color: const Color(0xffc2c2c2),
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
          );
  }
}
