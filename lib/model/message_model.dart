class MessageModel {
  String id, text, senderId, receiverId;
  DateTime time;

  MessageModel(this.id, this.text, this.senderId, this.receiverId, this.time);

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'senderId': senderId,
    'receiverId': receiverId,
    'time': time.toIso8601String(),
  };

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    json['id'],
    json['text'],
    json['senderId'],
    json['receiverId'],
    DateTime.parse(json['time']),
  );
}
