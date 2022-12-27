import 'dart:async';

import 'package:clean_arch_udemy/clean_project/presentation/resourses/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../resourses/app_color.dart';
import '../resourses/assets_manger.dart';
import '../resourses/values_style.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  void initState() {
    _timer = Timer(const Duration(seconds: AppValues.delay), goNext());
    super.initState();
  }

  goNext() => Navigator.pushReplacementNamed(context, Routes.startPageRoute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Stack(children: [
        whiteCircle(AppValues.top, AppValues.right),
        Center(child: Image.asset(AssetsManger.splashImage)),
        whiteCircle(AppValues.bottom, AppValues.left)
      ]),
    );
  }

  @override
  void dispose() {
    _timer
        ?.cancel(); //to a void crash,since  this page after timer will be destroyed
    super.dispose();
  }

  Positioned whiteCircle(double top, double right) {
    return Positioned(
        top: top,
        right: right,
        child: CircleAvatar(
          radius: AppValues.radius,
          backgroundColor: AppColor.primaryBackground,
        ));
  }
}
