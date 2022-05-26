class User {
  String fullname;
  String email;
  String gender;
  String password;

  User(
      {required this.fullname,
      required this.email,
      required this.gender,
      required this.password});

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "gender": gender,
        "password": password
      };
}
