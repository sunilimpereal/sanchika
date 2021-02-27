class User {
  String email;
  String firstName;
  String password;
  String mobile;
  User({
    this.email,
    this.firstName,
    this.password,
    this.mobile,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map.addAll({
      'email': email,
      'name': firstName,
      'password': password,
      'mobile': mobile,
    });
    return map;
  }
}
