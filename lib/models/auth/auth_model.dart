class UserDataModel {
  String id;
  String name;
  String email;
  String createdAt;

  UserDataModel({
    this.id,
    this.name,
    this.email,
    this.createdAt,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      createdAt: json['created_at'],
    );
  }
}

class UserLoginModel {
  final String token;
  final String message;

  UserLoginModel({this.token, this.message});

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      token: json['data']['token'],
      message: json['message'],
    );
  }
}
