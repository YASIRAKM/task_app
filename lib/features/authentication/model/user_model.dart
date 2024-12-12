import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String token;
  String image;
  String name;
  String position;
  int noOfTask;
  int percentage;

  UserModel({
    required this.token,
    required this.image,
    required this.name,
    required this.position,
    required this.noOfTask,
    required this.percentage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        image: json["image"],
        name: json["name"],
        position: json["position"],
        noOfTask: json["no_of_task"],
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "image": image,
        "name": name,
        "position": position,
        "no_of_task": noOfTask,
        "percentage": percentage,
      };
}
