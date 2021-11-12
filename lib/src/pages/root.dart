import 'package:antpire/config.dart';
import 'package:antpire/src/pages/authentication/login_page.dart';
import 'package:antpire/src/pages/sub_pages/sub_root.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:antpire/src/controllers/auth_controller.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (_) {
          return SafeArea(
              child: _.isSignedIn.value ? const SubRoot() : const LoginPage());
        },
      ),
    );
  }
}
