// ignore_for_file: non_constant_identifier_names, unnecessary_getters_setters

class Product {
  late final String _spendingID;
  late final String _priority;
  late final String _date;

  Product(this._spendingID, this._priority, this._date);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "spendingID": _spendingID,
      "priority": priority,
      "date": date
    };
    return map;
  }

  set id_spending(String spendingID) {
    _spendingID = spendingID;
  }

  set priority(String priority) {
    _priority = priority;
  }

  set date(String date) {
    _date = date;
  }

  String get spendingID => _spendingID;
  String get priority => _priority;
  String get date => _date;
}
