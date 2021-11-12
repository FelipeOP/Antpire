// ignore_for_file: non_constant_identifier_names, unnecessary_getters_setters
import 'package:antpire/src/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Spending {
  late final String name;
  late final int price;
  late final String priority;
  late final DocumentReference reference;
  late final DateTime date;
  // late final Product mainProduct;
  // late final List<Product> products;

  Spending(
      {required this.name,
      required this.price,
      required this.priority,
      required this.date});

  Map<String, dynamic> toJson() => _spendingToJson(this);

  factory Spending.fromJson(Map<String, dynamic>? json) =>
      _spendingeFromJson(json!);

  factory Spending.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Spending spending = Spending.fromJson(snapshot.data());
    spending.reference = snapshot.reference;
    return spending;
  }
}

Spending _spendingeFromJson(Map<String, dynamic> data) {
  return Spending(
      name: data['name'],
      price: data['price'],
      priority: data['priority'],
      date: data['date'] is Timestamp ? data['date'].toDate() : DateTime.now());
}

Map<String, dynamic> _spendingToJson(Spending spending) {
  Map<String, dynamic> map = {
    "name": spending.name,
    "price": spending.price,
    "priority": spending.priority,
    "date": spending.date
  };
  return map;
}
