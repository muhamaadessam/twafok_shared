import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
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
  var isDeviceConnected = true;

  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // Future<void> initConnectivity() async {
  //   late ConnectivityResult result;
  //   result = await _connectivity.checkConnectivity();
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //   return _updateConnectionStatus(result);
  // }

  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   if (result != ConnectivityResult.none) {
  //     var isConnect = await InternetConnectionChecker().hasConnection;
  //     setState(() {
  //       isDeviceConnected = isConnect;
  //     });
  //   } else {
  //     setState(() {
  //       isDeviceConnected = false;
  //     });
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   initConnectivity();
  //   _connectivitySubscription =
  //       _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  // }

  // @override
  // void dispose() {
  //   _connectivitySubscription.cancel();
  //   super.dispose();
  // }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: !isDeviceConnected
          ? Scaffold(
              body: FutureBuilder(
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    count++;
                    return Container();
                  }
                  if (snap.connectionState == ConnectionState.active) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
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
                  if (snap.connectionState == ConnectionState.done) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
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
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                future: Future.delayed(const Duration(seconds: 1)),
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
