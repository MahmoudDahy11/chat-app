import 'package:chat_app_mahmoud/constant.dart';

class Message {
  final String message;
  final String id;

  Message(this.message, this.id);

  factory Message.fromjson(jsonData) {
    return Message(jsonData[kMessage] , jsonData['id']);
  }
}
