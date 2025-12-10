class User {
  final String userId;
  final String username;
  final String password;

  User({required this.userId, required this.username, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'username': username, 'password': password};
  }
}
