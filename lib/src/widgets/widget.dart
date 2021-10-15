import 'package:flutter/material.dart';
import 'package:antpire/src/pages/start_page.dart';
import 'package:get/get.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({Key? key, required route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.arrow_back),
      backgroundColor: Colors.red[800],
      focusColor: Colors.red[800],
      autofocus: true,
      onPressed: () {
        Get.to(() => const StartPage());
      },
    );
  }
}
