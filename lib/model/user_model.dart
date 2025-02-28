class UserModel {
  String id;
  String name;
  String email;
  String phone;
  String avatar;

  UserModel({
    this.id = "",
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
  });

  static Map<String, dynamic> toJson(UserModel user) {
    return {
      "id": user.id,
      "name": user.name,
      "email": user.email,
      "phone": user.phone,
      "avatar": user.avatar
    };
  }

  static UserModel fromJson(Map<String, dynamic> model) {
    return UserModel(
        id: model["id"],
        name: model["name"],
        email: model["email"],
        phone: model["phone"],
        avatar: model["avatar"]);
  }
}
