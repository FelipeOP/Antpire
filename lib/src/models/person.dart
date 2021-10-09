// ignore_for_file: unnecessary_getters_setters

class Person {
  String _id = '';
  String _names = '';
  String _surnames = '';
  String _email = '';
  String _password = '';
  int _age = 0;
  double _salary = 0.0;
  String _frecuency = '';

  Person(this._id, this._names, this._surnames, this._email, this._password,
      this._age, this._salary, this._frecuency);

  Person.map(dynamic obj) {
    this._names = obj['names'];
    this._surnames = obj['surnames'];
    this._email = obj['email'];
    this._password = obj['password'];
    this._age = obj['age'];
    this._salary = obj['salary'];
    this._frecuency = obj['frecuency'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "names": names,
      "surnames": surnames,
      "age": age,
      "email": email,
      "password": password,
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

  // Person.fromSnapShot(Snapshot snapshot) {
  //   _id = snapshot.key!;
  //   _names = snapshot.value['names'];
  //   _surnames = snapshot.value['surnames'];
  //   _email = snapshot.value['email'];
  //   _password = snapshot.value['password'];
  //   _age = snapshot.value['age'];
  //   _salary = snapshot.value['salary'];
  //   _frecuency = snapshot.value['frecuency'];
  // }
}
