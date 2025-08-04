import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.phone,
    required super.email,
    required super.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
    email: json['email'],
    image: json['image'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'image': image,
  };
}
