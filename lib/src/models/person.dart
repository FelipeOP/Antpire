class Person {
  late final String names;
  late final String surnames;
  late final String email;
  late final String password;
  late final int age;
  late final int salary;
  late final String frequency;

  Person(
      {required this.names,
      required this.surnames,
      required this.email,
      required this.password,
      required this.age,
      required this.salary,
      required this.frequency});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "names": names,
      "surnames": surnames,
      "age": age,
      "email": email,
      "salary": salary,
      "frequency": frequency
    };
    return map;
  }
}
