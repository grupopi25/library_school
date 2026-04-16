class UserModel {
  final int id; 
  final String name;
  final String email;
  final String password;
  final bool status;
  final int? ano;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.status,
    this.ano,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'], 
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      status: map['status'] == true,
      ano: map['ano'] != null ? int.tryParse(map['ano'].toString()) : null,
    );
  }
}