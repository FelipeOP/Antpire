// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  get formKey => _formKey;
  get emailController => _emailController;
  get passwordController => _passwordController;

  void signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      Get.snackbar('Hola', 'Su registro ha sido exitoso');
      // ignore: avoid_print
      print('Ingresó correctamente');
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.toNamed("/StartPage");
        },
      );
    } catch (e) {
      Get.snackbar('Error',
          'No se pudo registrar de forma correcta, vuelva a digitar los datos',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _signOut() async {
    await _auth.signOut();
  }

  void signOut() async {
    final User user = await _auth.currentUser;
    if (user == null) {
      Get.snackbar('Out', 'No one has signed in.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    _signOut;
    final String userID = user.uid;
    Get.snackbar('Out', userID + ' has successfully signed out.',
        snackPosition: SnackPosition.BOTTOM);
    Get.toNamed("/home");
  }

  void signInWithGoogle() async {
    try {
      UserCredential userCredential;

      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);

      final user = userCredential.user;
      Get.snackbar('Hola${user.uid},', 'iniciaste sesión con google');
      print('Ingresó de forma correcta');
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.toNamed("/StartPage");
        },
      );
    } catch (e) {
      print(e);

      Get.snackbar('Error', 'No se pudo iniciar cuenta con Google $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
