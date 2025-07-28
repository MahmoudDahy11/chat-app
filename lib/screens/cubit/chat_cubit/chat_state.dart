part of 'chat_cubit.dart';

@immutable
class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
   List<Message> messages = [];
  ChatSuccess({required this.messages});
}

class ChatFailure extends ChatState {}
