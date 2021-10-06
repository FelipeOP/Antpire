// ignore_for_file: unnecessary_getters_setters

class User {
  String _names = '';
  String _surnames = '';
  String _email = '';
  String _password = '';
  int _age = 0;
  double _salary = 0.0;
  String _frecuency = '';

  User.register(this._names, this._email, this._password);

  User(this._names, this._surnames, this._email, this._password, this._age,
      this._salary, this._frecuency);

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

  set fecuency(String frecuency) {
    _frecuency = frecuency;
  }

  String get names => _names;
  String get surnames => _surnames;
  String get email => _email;
  String get password => _password;
  int get age => _age;
  double get salary => _salary;
  String get frecuency => _frecuency;
}
