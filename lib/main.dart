import 'package:antpire/controller_bindings.dart';
import 'package:antpire/src/pages/root.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseMessaging.instance.getToken();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        toggleableActiveColor: Colors.red,
        primaryColor: Colors.red,
        selectedRowColor: Colors.red,
        textTheme: GoogleFonts.josefinSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialBinding: ControllerBindings(),
      debugShowCheckedModeBanner: false,
      title: "Antpire",
      home: const Root(),
      // initialRoute: StartPage.id,
    );
  }
}
