import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shrimp_care_mobileapp/base/constant/app_constant.dart';
import 'dart:async';
import 'package:shrimp_care_mobileapp/utils/colors.dart';
import 'package:shrimp_care_mobileapp/utils/textstyle.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _rotationAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 3.14159), weight: 1),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 3.14159, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    Timer(const Duration(seconds: 1), () {
      _controller.repeat();
    });

    Timer(const Duration(milliseconds: 2500), () {
      context.go('/session');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.primary,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/core/bg_splash.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(_rotationAnimation.value),
                      child: Image.asset(
                        'assets/images/core/icon_shrimp_care.png',
                        width: 250,
                      ),
                    );
                  },
                ),
                Text(
                  'SHRIMP CARE',
                  style: MyTextStyle.text24.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                AppConstants.appName + ' v' + AppConstants.appVersion,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
