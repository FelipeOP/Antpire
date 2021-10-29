import 'package:antpire/src/controllers/auth_controller.dart';
import 'package:antpire/src/models/person.dart';
import 'package:antpire/src/models/spending.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class Firestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _authController = Get.find<AuthController>();

  Future<void> addUser(Map<String, dynamic> person) async {
    try {
      await _firestore
          .collection('users')
          .doc(_authController.userID)
          .collection('data')
          .doc('private')
          .set(person);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    return _firestore
        .collection('users')
        .doc(_authController.userID)
        .collection('data')
        .doc('private')
        .get()
        .then((doc) {
      return doc.data();
    }).onError((e, stackTrace) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.TOP);
    });
  }

  Future<String> updateUserData({int? salary, String? frequency}) async {
    try {
      await _firestore
          .collection('users')
          .doc(_authController.userID)
          .collection('data')
          .doc('private')
          .update({"salary": salary, "frequency": frequency}).onError(
              // ignore: void_checks
              (e, stackTrace) {
        _authController.getErrorMessage(e);
        Firestore()
            .addUser(_authController.userGoogleToJson(salary!, frequency!));
        return 'created';
      });
    } catch (e) {
      _authController.getErrorMessage(e);
    }
    return 'updated';
  }

  Future<void> deleteUser() async {
    try {
      await _firestore.collection('users').doc(_authController.userID).delete();
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }

  // Post
  Future<void> addSpending(Spending spending) async {
    try {
      await _firestore
          .collection('users')
          .doc(_authController.userID)
          .collection('spending')
          .doc(spending.name)
          .set(spending.toJson());
    } catch (e) {
      Get.snackbar(
        'Error occured!',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  //Get
  CollectionReference<Map<String, dynamic>> getAllSpendings() {
    return _firestore
        .collection('users')
        .doc(_authController.userID)
        .collection('spending');
  }

  Future<void> deleteSpending(Spending spending) async {
    try {
      await _firestore
          .collection('users')
          .doc(_authController.userID)
          .collection('spending')
          .doc(spending.name)
          .delete();
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.TOP);
    }
  }
}
