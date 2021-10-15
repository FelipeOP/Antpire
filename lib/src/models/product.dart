// ignore_for_file: unnecessary_getters_setters

class Product {
  late final String _id;
  late final double _price;
  late final String _description;

  Product(this._id, this._price, this._description);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "price": price,
      "description": description
    };
    return map;
  }

  set id(String id) {
    _id = id;
  }

  set price(double price) {
    _price = price;
  }

  set description(String description) {
    _description = description;
  }

  String get id => _id;
  double get price => _price;
  String get description => _description;
}
