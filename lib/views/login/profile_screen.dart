import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/const/app_const.dart';
import '../../core/theme/app_colors.dart';
import '../../main.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var name = '';
  var role = '';

  @override
  void initState() {
    super.initState();
    _loadEmployeeName();
  }

  Future<void> _loadEmployeeName() async {
    String employeeName = await getEmployeeName();
    String employeeRole = await getRole();
    setState(() {
      name = employeeName;
      role = employeeRole;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AppConst.user_1))),
              ),
              const SizedBox(height: 20),
              // Name
              Text(
                name, // Replace with user's name
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              /*   Text(
                department, // Replace with user's email
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),*/
              // Email or other details
              Text(
                role, // Replace with user's email
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),

              // Logout Button
              ElevatedButton(
                onPressed: () {
                  // Add your logout logic here
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(context.tr('confirm_logout')),
                      content: Text(context.tr('exit_question')),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(context.tr('cancel')),
                        ),
                        TextButton(
                          onPressed: () async {
                            await prefs.removeToken();
                            await prefs.removeEmployee();
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: Text(context.tr(
                            'exit',
                          )),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  context.tr('exit'),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getRole() async {
    String role = '';
    var employee = await prefs.getEmployee();
    var data = employee?.role;

    for (String value in data!) {
      role = '$role $value';
    }

    return role;
  }

  Future<String> getEmployeeName() async {
    var employee = await prefs.getEmployee();
    if (employee?.firstName != null && employee?.lastName != null) {
      return '${employee?.firstName} ${employee?.lastName}';
    } else {
      return '${employee?.username}';
    }
  }
}
