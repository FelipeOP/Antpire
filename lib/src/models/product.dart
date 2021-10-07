// ignore_for_file: unnecessary_getters_setters

class Product {
  late int _productID;

  int get productID => _productID;

  set productID(int productID) {
    _productID = productID;
  }

  late String _description;

  String get description => _description;

  set description(String description) {
    _description = description;
  }

  late double _price;

  double get price => _price;

  set price(double price) {
    _price = price;
  }
}
