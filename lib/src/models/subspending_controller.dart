class Sub_spending {
  late final String _id_sub_spending;
  late final String _date;
  late final String _description;

  Sub_spending(this._id_sub_spending, this._date, this._description);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id_sub_spending": id_sub_spending,
      "date": date,
      "description": description
    };
    return map;
  }

  set id_sub_spending(String id_sub_spending) {
    _id_sub_spending = id_sub_spending;
  }

  set date(String date) {
    _date = date;
  }

  set description(String description) {
    _description = description;
  }

  String get id_sub_spending => _id_sub_spending;
  String get date => _date;
  String get description => _description;
}
