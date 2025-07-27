import 'package:chat_app_mahmoud/constant.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromJson(jsonData) {
    return Message(
      jsonData[kMessage] ?? '', // default to empty string
      jsonData['id'] ?? '', // default to empty string
    );
  }
}
