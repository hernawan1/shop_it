import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_it/common/shared_prefs_services.dart';
import 'package:shop_it/gen/asset.gen.dart';
import 'package:shop_it/src/auth/screen/login.dart';
import 'package:shop_it/src/disconnect.dart';
import 'package:shop_it/src/produk/screen/produk.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectionSubscription;
  bool? isOnline;

  Future<void> checkNetwork() async {
    late ConnectivityResult result;
    result = await connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      setState(() {
        isOnline = true;
      });
    } else {
      setState(() {
        isOnline = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      checkNetwork().then((value) {
        if (isOnline!) {
          SharedPrefsServices().getToken().then((value) {
            if (value != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (_) => const Produk()),
                  (route) => false);
            } else {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (_) => const Login()));
            }
          });
        } else {
          Navigator.push(context,
              CupertinoPageRoute(builder: (_) => const Disconnected()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Assets.images.login.image(height: 50),
        ),
      ),
    );
  }
}
