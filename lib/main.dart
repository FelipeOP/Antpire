import 'package:antpire/src/pages/start_page.dart';
import 'package:antpire/src/routes/antpire_routes.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "Antpire",
      debugShowCheckedModeBanner: false,
      home: StartPage(),
      // initialRoute: StartPage.id,
    );
  }
}
