// ignore_for_file: unnecessary_getters_setters

class Product {
  late final String _id_product;
  late final double _price;
  late final String _description;

  Product(this._id_product, this._price, this._description);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id_product": id_product,
      "price": price,
      "description": description
    };
    return map;
  }

  set id(String id_product) {
    _id_product = id_product;
  }

  set price(double price) {
    _price = price;
  }

  set description(String description) {
    _description = description;
  }

  String get id_product => _id_product;
  double get price => _price;
  String get description => _description;
}
