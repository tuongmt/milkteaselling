import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModeltoJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String username;
  String? password;
  String fullName;
  String address;
  String phoneNumber;
  String email;
  String? roleId;
  String? image;

  UserModel({
    required this.id,
    required this.username,
    this.password,
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    required this.email,
    this.roleId,
    this.image,
  });
  static UserModel userEmpty(){
    return new UserModel(
      id: 0,
      username: "",
      password: "",
      fullName: "",
      address: "",
      phoneNumber: "",
      email: "",
      roleId: "",
      image: "",
    );
  }



  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? 0,
        username: json["username"],
        password: json["password"] ?? "",
        fullName: json["fullName"] ?? "",
        address: json["address"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        email: json["email"] ?? "",
        roleId: json["roleId"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "password": password,
        "fullName": fullName,
        "address": address,
        "phoneNumber": phoneNumber,
        "email": email,
        "roleId": roleId,
        "image": image,
      };
  String toJson() => jsonEncode(this.toMap());

  UserModel copyWith() =>
      UserModel(
          id: id,
          username: username,
          password: password,
          fullName: fullName,
           address: address,
             phoneNumber: phoneNumber,
          email: email,
          roleId: roleId ,
          image: image,
        );
}
