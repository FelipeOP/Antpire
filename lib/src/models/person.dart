// ignore_for_file: unnecessary_getters_setters

class Person {
  late final String _id;
  late final String _names;
  late final String _surnames;
  late final String _email;
  late final String _password;
  late final int _age;
  late final double _salary;
  late final String _frecuency;

  Person(this._id, this._names, this._surnames, this._email, this._password,
      this._age, this._salary, this._frecuency);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id:": id,
      "names": names,
      "surnames": surnames,
      "age": age,
      "email": email,
      "salary": salary,
      "frecuency": frecuency
    };
    return map;
  }

  set id(String id) {
    _id = id;
  }

  set names(String names) {
    _names = names;
  }

  set surnames(String surnames) {
    _surnames = surnames;
  }

  set email(String email) {
    _email = email;
  }

  set password(String password) {
    _password = password;
  }

  set age(int age) {
    _age = age;
  }

  set salary(double salary) {
    _salary = salary;
  }

  set frecuency(String frecuency) {
    _frecuency = frecuency;
  }

  String get id => _id;
  String get names => _names;
  String get surnames => _surnames;
  String get email => _email;
  String get password => _password;
  int get age => _age;
  double get salary => _salary;
  String get frecuency => _frecuency;
}
