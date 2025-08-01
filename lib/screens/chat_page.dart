import 'package:chat_app_mahmoud/components/chat_bubble.dart';
import 'package:chat_app_mahmoud/constant.dart';
import 'package:chat_app_mahmoud/models/message.dart';
import 'package:chat_app_mahmoud/screens/cubit/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  String id = 'ChatPage';

  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Message> messgeList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png', height: 50),
            Text('chat', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messgeList = state.messages;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messgeList.length,
                  itemBuilder: (context, index) {
                    return messgeList[index].id == email
                        ? ChatBubble(message: messgeList[index])
                        : ChatBubbleForFriend(message: messgeList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                {
                  BlocProvider.of<ChatCubit>(
                    context,
                  ).sendMessage(message: data, email: email);
                  controller.clear();
                  _scrollController.animateTo(
                    0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                }
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


