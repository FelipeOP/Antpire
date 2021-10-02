import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: GetBuilder<AuthController>(
      builder: (_authController) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Hello ${_authController.displayName.toString()}!',
            ),
            Expanded(flex: 8, child: Container()),
            TextButton(
              child: const Text('Sign out'),
              onPressed: () => _authController.signout(),
            ),
          ],
        );
      },
    ));
  }
}
