import 'package:antpire/controller_bindings.dart';
import 'package:antpire/src/pages/start_page.dart';
import 'package:antpire/src/pages/restore_page.dart';
import 'package:antpire/src/routes/antpire_routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      title: "Antpire",
      home: const StartPage(),
      // initialRoute: StartPage.id,
    );
  }
}
