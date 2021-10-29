import 'package:antpire/src/models/spending.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final spending = <Spending>[].obs;

  @override
  void onInit() {
    // spending.bindStream(Firestore().getAllSpendings());
    super.onInit();
  }
}
