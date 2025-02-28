class PostUserModel {
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? phone;
  int? avaterId;

  PostUserModel(
      {this.name,
      this.email,
      this.password,
      this.confirmPassword,
      this.phone,
      this.avaterId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    data['phone'] = this.phone;
    data['avaterId'] = this.avaterId;
    return data;
  }
}
