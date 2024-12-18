import 'package:flutter/material.dart';
import 'package:mobile_ung/core/const/app_const.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppConst.background), fit: BoxFit.none, repeat: ImageRepeat.repeat)),
            child: Center(child: Image.asset(AppConst.logo, width: 220, height: 210))));
  }
}
