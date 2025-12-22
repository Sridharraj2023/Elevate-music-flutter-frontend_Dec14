// models/user.dart
class User {
  final int? id;
  final String username;
  final String email;
  final String password;
  final String? role;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.role,
  });

  // Convert JSON response into User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? json["_id"],
      username: json["name"] ?? json["username"] ?? "",
      email: json["email"] ?? "",
      password: "", // Never expose password from API
      role: json["role"] ?? "user",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": username,
      "email": email,
      "password": password,
      "role": role ?? "user",
    };
  }
}
