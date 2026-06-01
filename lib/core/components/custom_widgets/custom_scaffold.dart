import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
  var isDeviceConnected = false;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>>
      _connectivitySubscription; // ✅ List<ConnectivityResult>

  Future<void> initConnectivity() async {
    final results = await _connectivity
        .checkConnectivity(); // ✅ returns List<ConnectivityResult>
    if (!mounted) return;
    return _updateConnectionStatus(results);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    // ✅ List<ConnectivityResult>
    if (!results.contains(ConnectivityResult.none)) {
      final isConnect = await InternetConnectionChecker
          .instance.hasConnection; // ✅ named constructor
      if (mounted) setState(() => isDeviceConnected = isConnect);
    } else {
      if (mounted) setState(() => isDeviceConnected = false);
    }
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen(_updateConnectionStatus); // ✅ matches new stream type
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLogger.debug(
        'Building CustomScaffold, isDeviceConnected: $isDeviceConnected');
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
