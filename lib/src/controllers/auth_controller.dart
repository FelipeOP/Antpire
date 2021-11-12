// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:antpire/src/models/person.dart';
import 'package:antpire/src/pages/root.dart';
import 'package:antpire/src/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var displayName = '';
  var userID = '';
  var userEmail = '';
  var isSignedIn = false.obs;
  final _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  FirebaseAuth auth = FirebaseAuth.instance;

  User? get userProfile => auth.currentUser;

  @override
  void onInit() {
    displayName = userProfile != null ? userProfile!.displayName! : '';
    userID = userProfile != null ? userProfile!.uid : '';
    userEmail = userProfile != null ? userProfile!.email! : '';
    super.onInit();
  }

  @override
  void dispose() {
    displayName = '';
    userID = '';
    userEmail = '';
    super.dispose();
  }

  void signUp(Person person) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: person.email, password: person.password)
          .then((value) {
        displayName = person.names + ' ' + person.surnames;
        userID = userProfile!.uid;
        userProfile!.updateDisplayName(displayName);
        Firestore().addUser(person.toMap());
      });
      update();
      Get.offAll(() => const Root());
    } on FirebaseAuthException catch (e) {
      getErrorMessage(e);
    } catch (e) {
      getErrorMessage(e);
    }
  }

  void signIn(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayName = userProfile!.displayName!;
        userID = userProfile!.uid;
        userEmail = userProfile!.email!;
      });
      isSignedIn.value = true;
      update();
      Get.offAll(() => const Root());
    } on FirebaseAuthException catch (e) {
      getErrorMessage(e);
    } catch (e) {
      getErrorMessage(e);
    }
  }

  Map<String, dynamic> userGoogleToJson(int salary, String frequency) {
    List<String> fullName = displayName.split(' ');
    Map<String, dynamic> googleUser = {
      'names': fullName[0],
      'surnames': fullName[1],
      'email': userEmail,
      'salary': salary,
      'frequency': frequency
    };
    return googleUser;
  }

  void signInWithGoogle() async {
    try {
      googleAccount.value = await _googleSignIn.signIn().then((result) {
        result!.authentication.then((googleKey) {
          userID = googleKey.idToken!.substring(0, 28);
          displayName = _googleSignIn.currentUser!.displayName!;
          userEmail = _googleSignIn.currentUser!.email;
        });
      });
      isSignedIn.value = true;
      update(); // <-- without this the isSignedin value is not updated.
      Get.offAll(() => const Root());
    } catch (e) {
      getErrorMessage(e);
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.back();
    } on FirebaseAuthException catch (e) {
      getErrorMessage(e);
    } catch (e) {
      getErrorMessage(e);
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
      await _googleSignIn.signOut();
      displayName = '';
      userID = '';
      userEmail = '';
      isSignedIn.value = false;
      update();
      Get.offAll(() => const Root());
    } catch (e) {
      getErrorMessage(e);
    }
  }

  Future<void> deleteAccount() async {
    try {
      if (userProfile != null) {
        userProfile!.delete();
      }
      Firestore().deleteUser();
      isSignedIn.value = false;
      update();
      Get.offAll(() => const Root());
    } catch (e) {
      getErrorMessage(e);
    }
  }

  // ignore: prefer_void_to_null
  Future<Null> getErrorMessage(dynamic e) async {
    String title = e.toString();
    String message = '';

    if (e is FirebaseAuthException || e is FirebaseException) {
      title = e.code.toString();
    }

    switch (title) {
      case 'Null check operator used on a null value':
        title = 'Valores nulos';
        message = 'Es posible que haya información sin completar';
        break;
      case 'wrong-password':
        title = 'Contraseña incorrecta!';
        message = 'Contraseña inválida. Por favor inténtalo de nuevo';
        break;
      case 'user-not-found':
        title = 'El usuario no está registrado.';
        message = ('La cuenta no existe. Crea tu cuenta para iniciar sesión.');
        break;
      case 'weak-password':
        title = 'Contraseña vulnerable';
        message = 'Incluye por lo menos un número y un caracter especial';
        break;
      case 'email-already-in-use':
        title = 'Correo en uso!';
        message = 'Ya existe una cuenta con ese correo UnU';
        break;
      case 'not-found':
        title = 'Error 404';
        message = 'No se encuentra el documento solicitado.';
        break;
      default:
        title = 'Error interno';
        message = 'Ha ocurrido un error inesperado U.U .';
    }

    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL);
  }

  // Actualización 2.0 coming soon 2077
  /*
  - White mode 
  - Dark mode
  - Machine learning
  - Fix bugs
  - launch Deiber 2.0
  - launch IOS version
  */

}
