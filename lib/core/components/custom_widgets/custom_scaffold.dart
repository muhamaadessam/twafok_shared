import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

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
  bool isConnected = true;

  final _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _sub;

  @override
  void initState() {
    super.initState();
    _init();

    _sub = _connectivity.onConnectivityChanged.listen((result) {
      _handle(result);
    });
  }

  Future<void> _init() async {
    final result = await _connectivity.checkConnectivity();
    _handle(result);
  }

  void _handle(List<ConnectivityResult> result) {
    final hasNetwork =
        result.isNotEmpty && result.any((r) => r != ConnectivityResult.none);

    setState(() {
      isConnected = hasNetwork;
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isConnected) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 120),
              SizedBox(height: 10),
              Text("No Internet Connection"),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: widget.appBar,
      drawer: widget.drawer,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      bottomNavigationBar: widget.bottomNavigationBar,
      body: widget.body,
    );
  }
}
