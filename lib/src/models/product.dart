// ignore_for_file: unnecessary_getters_setters

class Product {
  late final String _description;
  late final double _price;
  late final String _priority;

  Product(this._description, this._price, this._priority);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "priority": priority,
      "description": description,
      "price": price
    };
    return map;
  }

  set id(String priority) {
    _priority = priority;
  }

  set price(double price) {
    _price = price;
  }

  set description(String description) {
    _description = description;
  }

  String get priority => _priority;
  double get price => _price;
  String get description => _description;
}
