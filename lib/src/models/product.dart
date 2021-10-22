// ignore_for_file: unnecessary_getters_setters

class Product {
  late final String _productID;
  late final double _price;
  late final String _description;

  Product(this._productID, this._price, this._description);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "productID": productID,
      "price": price,
      "description": description
    };
    return map;
  }

  set id(String productID) {
    _productID = productID;
  }

  set price(double price) {
    _price = price;
  }

  set description(String description) {
    _description = description;
  }

  String get productID => _productID;
  double get price => _price;
  String get description => _description;
}
