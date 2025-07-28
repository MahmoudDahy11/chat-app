import 'package:chat_app_mahmoud/firebase_options.dart';
import 'package:chat_app_mahmoud/screens/chat_page.dart';
import 'package:chat_app_mahmoud/screens/cubit/auth_cubit/auth_cubit.dart';
import 'package:chat_app_mahmoud/screens/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app_mahmoud/screens/login_page.dart';
import 'package:chat_app_mahmoud/screens/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),

        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage().id: (context) => ChatPage(),
        },
        initialRoute: LoginPage.id,
      ),
    );
  }
}
