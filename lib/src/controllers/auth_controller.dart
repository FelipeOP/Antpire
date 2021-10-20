// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:antpire/src/models/person.dart';
import 'package:antpire/src/pages/root.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var displayName = '';
  var isSignedIn = false.obs;
  final _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  User? get userProfile => auth.currentUser;

  @override
  void onInit() {
    displayName = userProfile != null ? userProfile!.displayName! : '';
    super.onInit();
  }

  void signUp(Person person) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: person.email, password: person.password)
          .then((value) {
        displayName = person.names;
        auth.currentUser!.updateDisplayName(person.names);
      });
      update();
      addUserInformation(person);
      Get.offAll(() => const Root());
    } on FirebaseAuthException catch (e) {
      String title = e.code;
      String message = '';

      if (e.code == 'weak-password') {
        message = 'La contraseña dada es muy debil';
      } else if (e.code == 'email-already-in-use') {
        message = 'Hay una cuenta con ese correo';
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void signIn(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => displayName = userProfile!.displayName!);
      isSignedIn.value = true;
      update();
      Get.offAll(() => const Root());
    } on FirebaseAuthException catch (e) {
      String title = '';
      String message = '';
      if (e.code == 'wrong-password') {
        title = 'Contraseña incorrecta!';
        message = 'Contraseña inválida. Por favor inténtalo de nuevo';
      } else if (e.code == 'user-not-found') {
        title = 'El usuario no está registrado.';
        message =
            ('La cuenta no existe para $email. Crea tu cuenta para iniciar sesión.');
      } else {
        title = 'Se ha producido un error inesperado.';
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void signInWithGoogle() async {
    try {
      googleAccount.value = await _googleSignIn.signIn();
      displayName = googleAccount.value!.displayName!;
      isSignedIn.value = true;
      update(); // <-- without this the isSignedin value is not updated.
      Get.offAll(() => const Root());
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.back();
    } on FirebaseAuthException catch (e) {
      String title = '';
      String message = '';

      if (e.code == 'user-not-found') {
        message =
            ('La cuenta no existe para $email. Crea tu cuenta para iniciar sesión');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error ocured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void signout() async {
    try {
      await auth.signOut();
      await _googleSignIn.signOut();
      displayName = '';
      isSignedIn.value = false;
      update();
      Get.offAll(() => const Root());
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> addUserInformation(Person person) async {
    try {
      await _firestore
          .collection('users')
          .doc(auth.currentUser!.uid.toString())
          .collection('data')
          .doc('private')
          .set(person.toMap());
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  Future<void> addFinalcialInformation() async {}
}
