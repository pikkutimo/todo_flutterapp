class User {
  final String token;
  final String username;
  final String name;

  const User({
    required this.token,
    required this.username,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      username: json['username'],
      name: json['name'],
    );
  }
}
