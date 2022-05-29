class Login {
  final String accessToken;
  final String userId;

  Login({
    required this.accessToken,
    required this.userId,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(accessToken: json['accessToken'], userId: json['userId']);
  }
}
