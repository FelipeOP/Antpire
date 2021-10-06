import 'package:antpire/src/pages/home.dart';
import 'package:antpire/src/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:antpire/src/pages/register_page.dart';
import 'package:antpire/src/pages/start_page.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Config().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (_) {
          return SafeArea(
              child: _.isSignedIn.value ? const Home() : const LoginPage());
        },
      ),
    );
  }
}
