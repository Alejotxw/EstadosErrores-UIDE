class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;

  UserModel({
    required this.id, 
    required this.name, 
    required this.username, 
    required this.email
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Usuario sin nombre',
      username: json['username'] ?? 'n/a',
      email: json['email'] ?? 'sin-email@dominio.com',
    );
  }
}