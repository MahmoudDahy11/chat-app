import 'package:chat_app_mahmoud/constant.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromJson(jsonData) {
    if (jsonData[kMessage] == null || jsonData['id'] == null) {
      throw Exception("Missing required fields in Message JSON");
    }
    return Message(
      jsonData[kMessage] ?? '', 
      jsonData['id'] ?? '', 
    );
  }
}
