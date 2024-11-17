class UserModel {
  final String uuid;
  final String email;
  final String name;

  UserModel({required this.uuid, required this.email, required this.name});

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {"uuid": uuid, "email": email, "name": name};
  }

  // Convert to model
  factory UserModel.fromJson(Map<String, dynamic> jsonUser) {
    return UserModel(
        uuid: jsonUser["uuid"],
        email: jsonUser["email"],
        name: jsonUser["name"]);
  }
}
