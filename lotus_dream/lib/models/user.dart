class User {
  final String id;
  final String phone;
  final String? name;

  User({required this.id, required this.phone, this.name});
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'].toString(),
    name: json['name'] ?? '',
    phone: json['phone'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
 };
  
}
