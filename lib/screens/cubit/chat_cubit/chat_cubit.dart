import 'package:bloc/bloc.dart';
import 'package:chat_app_mahmoud/constant.dart';
import 'package:chat_app_mahmoud/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );

  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        kMessage: message,
        kCraetedAT: DateTime.now(),
        'id': email,
      });
    } catch (e) {
      emit(ChatFailure());
    }
  }

  void getMessages() {
    messages.orderBy(kCraetedAT, descending: true).snapshots().listen((event) {
      List<Message> messageList = [];

      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messageList));
    });
  }
}
