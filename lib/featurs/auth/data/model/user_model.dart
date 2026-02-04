class UserModel {
  static String collection = "user";
  String? email;
  String? userName;
  String? password;
  String? id;
  UserModel({this.email, this.id, this.password, this.userName});
  UserModel.fromJson(Map<String, dynamic?> json)
    : this(
        email: json['email'],
        id: json['id'],
        password: json['password'],
        userName: json['userName'],
      );
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "userName": userName,
      "id": id,
      "password": password,
    };
  }
}

void main() {
  var user = UserModel(
    email: "abdomoshref@gmail.com",
    id: "1",
    password: "01234",
    userName: "abdo  moshref",
  );
  var map = user.toJson();
  print(map);
}
