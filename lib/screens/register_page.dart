import 'package:chat_app_mahmoud/components/custom_botton.dart';
import 'package:chat_app_mahmoud/components/custom_text_field.dart';
import 'package:chat_app_mahmoud/constant.dart';
import 'package:chat_app_mahmoud/helper/show_snak_bar.dart';
import 'package:chat_app_mahmoud/screens/chat_page.dart';
import 'package:chat_app_mahmoud/screens/cubit/register_cubit/register_cubit_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  String? email;
  static String id = 'RegisterPage';
  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.of(context).pushNamed(ChatPage().id);
        } else if (state is RegisterFailure) {
          showSnakBar(context, state.errMessage);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    SizedBox(height: 75),
                    Image.asset('assets/images/scholar.png', height: 120),
                    Text(
                      textAlign: TextAlign.center,
                      'Scholar Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    SizedBox(height: 75),
                    Row(
                      children: [
                        Text(
                          'REGISTER',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    CustomTextFromField(
                      hintText: 'Email',
                      onChange: (data) {
                        email = data;
                      },
                    ),
                    SizedBox(height: 10),
                    CustomTextFromField(
                      obscureText: true,
                      hintText: 'Password',
                      onChange: (data) {
                        password = data;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomBotton(
                      text: 'Register',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(
                            context,
                          ).registerUser(email: email!, password: password!);
                        } else {}
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            ' Login',
                            style: TextStyle(
                              color: Color(0XFF949AA7),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
