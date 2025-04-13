class User {
  final String name;
  final String email;
  final String role;
  final String avatarUrl; // Can be a network URL or local asset path

  User({
    required this.name,
    required this.email,
    required this.role,
    required this.avatarUrl,
  });
}
