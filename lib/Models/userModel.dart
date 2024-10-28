class UserModel {
  final String email;
  final String userName;
  final String birthDay;
  final String circleBackground;
  final String coverBackground;

  UserModel({
    required this.userName,
    required this.email,
    required this.birthDay,
    required this.circleBackground,
    required this.coverBackground,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      coverBackground: json['cover_background'],
      circleBackground: json['circle_background'],
      userName: json['userName'],
      email: json['email'],
      birthDay: json['birthDay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'circle_background': circleBackground,
      'birthDay': birthDay,
      'cover_background': coverBackground,
    };
  }
}
