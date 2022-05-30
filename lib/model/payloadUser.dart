class PayloadUser {
  String fullname;
  String gender;
  String id;
  int iat;
  int exp;

  PayloadUser(
      {required this.fullname,
      required this.gender,
      required this.id,
      required this.iat,
      required this.exp});

  factory PayloadUser.fromJson(Map<String, dynamic> json) {
    return PayloadUser(
        fullname: json['fullname'],
        gender: json['gender'],
        id: json['_id'],
        iat: json['iat'],
        exp: json['exp']);
  }
}
