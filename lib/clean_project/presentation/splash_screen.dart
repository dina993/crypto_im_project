import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../crypto_project/presentation/crypto_page.dart';
import '../../crypto_project/utilities/app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // @override
  // void initState() {
  //   _timer = Timer(const Duration(seconds: AppConstants.delay),
  //       AppRouter.router.pushToNewWidget(const CryptoPageView(), context));
  //   super.initState();
  // }

  // goNext() => AppRouter.router.pushToNewWidget(const CryptoPageView());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('ERROR'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return const CryptoPageView();
          }
          return Scaffold(
            body: Stack(children: [
              Image.asset(AssetsManger.splashImage),
              whiteCircle(AppConstants.top, AppConstants.right),
              Image.asset(AssetsManger.logoImage),
              whiteCircle(AppConstants.bottom, AppConstants.left)
            ]),
          );
        });
  }

  @override
  // void dispose() {
  //   _timer
  //       ?.cancel(); //to a void crash,since  this page after timer will be destroyed
  //   super.dispose();
  // }

  Positioned whiteCircle(double top, double right) {
    return Positioned(
        top: top,
        right: right,
        child: CircleAvatar(
          radius: AppConstants.radius,
          backgroundColor: AppColor.primaryBackground,
        ));
  }
}
