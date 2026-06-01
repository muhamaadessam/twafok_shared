import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:twafok_shared/core/core.dart';

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
  bool isDeviceConnected = true;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void initState() {
    super.initState();

    _init();
    _subscription = _connectivity.onConnectivityChanged.listen(_onChange);
  }

  Future<void> _init() async {
    final result = await _connectivity.checkConnectivity();
    await _onChange(result);
  }

  Future<void> _onChange(List<ConnectivityResult> result) async {
    if (!mounted) return;

    final hasNetwork =
        result.isNotEmpty && result.any((r) => r != ConnectivityResult.none);

    if (!hasNetwork) {
      setState(() => isDeviceConnected = false);
      return;
    }

    // simple real internet check (NO packages)
    bool hasInternet = false;

    try {
      final lookup = await InternetAddress.lookup('google.com');
      hasInternet = lookup.isNotEmpty && lookup.first.rawAddress.isNotEmpty;
    } catch (_) {
      hasInternet = false;
    }

    if (!mounted) return;

    setState(() => isDeviceConnected = hasInternet);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Widget _noInternetView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.signal_wifi_connected_no_internet_4_rounded, size: 150),
          SizedBox(height: 12),
          TextTitle(
            'الجهاز غير متصل بالانترنت',
            color: Color(0xffc2c2c2),
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: widget.appBar,
        drawer: widget.drawer,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        bottomNavigationBar: widget.bottomNavigationBar,
        body: isDeviceConnected ? widget.body : _noInternetView(),
      ),
    );
  }
}
