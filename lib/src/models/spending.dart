class Product {
  late final String _id_spending;
  late final String _priority;
  late final String _date;

  Product(this._id_spending, this._priority, this._date);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id_spending": id_spending,
      "priority": priority,
      "date": date
    };
    return map;
  }

  set id_spending(String id_spending) {
    _id_spending = id_spending;
  }

  set priority(String priority) {
    _priority = priority;
  }

  set date(String date) {
    _date = date;
  }

  String get id_spending => _id_spending;
  String get priority => _priority;
  String get date => _date;
}
