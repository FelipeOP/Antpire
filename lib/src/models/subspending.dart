// ignore_for_file: unnecessary_getters_setters

class SubSpending {
  late final String _subSpendingID;
  late final String _date;
  late final String _description;

  SubSpending(this._subSpendingID, this._date, this._description);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "subSpendingID": _subSpendingID,
      "date": date,
      "description": description
    };
    return map;
  }

  set subSpendingID(String subSpendingID) {
    _subSpendingID = subSpendingID;
  }

  set date(String date) {
    _date = date;
  }

  set description(String description) {
    _description = description;
  }

  String get subSpendingID => _subSpendingID;
  String get date => _date;
  String get description => _description;
}
