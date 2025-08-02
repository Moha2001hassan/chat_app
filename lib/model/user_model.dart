class UserModel {
  String id, name, phone, image, email;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'image': image,
    'email': email,
  };
}
