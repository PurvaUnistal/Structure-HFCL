import 'dart:async';

import 'package:flutter/material.dart';
import 'package:structure_app/Utils/common_widget/SharedPerfs/Prefs_Value.dart';
import 'package:structure_app/Utils/common_widget/SharedPerfs/preference_utils.dart';
import 'package:structure_app/Utils/common_widget/app_string.dart';
import 'package:structure_app/Utils/routes/routes_name.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    toLogin();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  Future<void> toLogin() async {
    await PreferenceUtil().init();
    String email = await PreferenceUtil.getString(key: PrefsValue.emailVal);
    String password = await PreferenceUtil.getString(key: PrefsValue.passwordVal);
    Timer(
      const Duration(seconds: 2),
      () async {
        if (email.isNotEmpty || password.isNotEmpty) {
          Navigator.pushReplacementNamed(
            context,
            RoutesName.homeView,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            RoutesName.loginView,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              ImgAsset.appLogo,
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
