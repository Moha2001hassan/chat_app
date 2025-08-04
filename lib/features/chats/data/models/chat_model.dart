import 'package:chat_app/features/auth/data/models/user_model.dart';

class ChatModel {
  final String id;
  List<UserModel> users = [];
  List<String> usersId = [];
  List chat = [];

  ChatModel({
    required this.id,
    required this.users,
    required this.usersId,
    required this.chat,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    id: json['id'],
    users: json['users'].map((e) => UserModel.fromJson(e)).toList(),
    usersId: json['usersId'],
    chat: json['chat'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'users': users.map((e) => e.toJson()).toList(),
    'usersId': usersId,
    'chat': chat,
  };
}
