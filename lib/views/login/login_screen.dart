import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_ung/core/const/app_const.dart';
import 'package:mobile_ung/core/theme/app_colors.dart';
import 'package:mobile_ung/dto/auth/auth.dart';
import 'package:mobile_ung/network/auth_service.dart';

import '../../errors/app_not_installed.dart';
import '../../errors/user_not_found.dart';
import '../navbar_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final bool _rememberMe = true;
  late bool _isLoading = false;
  late bool _espLoading = false;
  late final String _errorMessage = '';

  final userNameController = TextEditingController(text: kDebugMode ? 'rizoyev.muhriddin' : null);
  final passwordController = TextEditingController(text: kDebugMode ? 'Xn4?hqZ^' : null);

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColors.danger,
      content: Text(message),
    ));
  }

  Future<void> login() async {
    String username = userNameController.text;
    String password = passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        setState(() {
          _isLoading = true;
        });

        var success = await AuthService.login(AuthCredentialsDto(username, password));

        if (success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const NavbarScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ma\'lumot topilmadi!'),
              duration: Durations.medium4,
            ),
          );
        }
      } on DioException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.danger,
            content: Text(
              error.response?.data?['message'] ?? 'Serverda xatolik!',
              style: const TextStyle(color: Colors.white),
            ),
            duration: Durations.extralong4,
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.danger,
            content: Text(
              'Serverda xatolik!',
              style: TextStyle(color: Colors.white),
            ),
            duration: Durations.extralong4,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maydonlarni to\'ldiring'),
          duration: Durations.medium3,
        ),
      );
    }
  }

  Future<void> loginByEsp() async {
    try {
      setState(() {
        _espLoading = true;
      });

      final result = await AuthService.loginByEsp(_rememberMe);

      if (result) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavbarScreen()),
        );
      }
    } on AppNotInstalledError {
      showErrorSnackBar('Sizda E-Imzo dasturi o\'rnatilmagan');
    } on UserNotFoundError {
      showErrorSnackBar('Foydalanuvchi topilmadi');
    } catch (error) {
      showErrorSnackBar('Tanlangan ERI bilan tizimga kirib bo\'lmadi');
      rethrow;
    } finally {
      setState(() {
        _espLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(AppConst.background), fit: BoxFit.none, repeat: ImageRepeat.repeat),
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 45),
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppConst.logo))),
              ),
              const SizedBox(height: 45),
              if (!kReleaseMode)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.inputBgLogin,
                      border: Border.all(color: AppColors.mainColor0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        maxLines: 1,
                        obscuringCharacter: '∗',
                        controller: userNameController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: 'Username',
                          border: InputBorder.none,
                          errorText: _errorMessage.isEmpty ? null : _errorMessage,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              if (!kReleaseMode)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.inputBgLogin,
                      border: Border.all(color: AppColors.mainColor0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              if (!kReleaseMode)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        shadowColor: Colors.black,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: login,
                      child: Text(
                        _isLoading ? 'Loading...' : context.tr('login'),
                        style: const TextStyle(
                          fontSize: 16, // Font size
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shadowColor: Colors.black,
                      backgroundColor: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: loginByEsp,
                    child: Text(
                      _espLoading ? 'Loading...' : context.tr('login_via_eri'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
