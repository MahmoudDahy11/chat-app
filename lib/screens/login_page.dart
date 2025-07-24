import 'package:chat_app_mahmoud/components/custom_botton.dart';
import 'package:chat_app_mahmoud/components/custom_text_field.dart';
import 'package:chat_app_mahmoud/constant.dart';
import 'package:chat_app_mahmoud/helper/show_snak_bar.dart';
import 'package:chat_app_mahmoud/screens/chat_page.dart';
import 'package:chat_app_mahmoud/screens/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  String id = 'LoginPage';
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                  SizedBox(height: 10),
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
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  CustomTextFromField(
                    hintText: 'Email',
                    onChange: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextFromField(
                    obscureText: true,
                    hintText: 'Password',
                    onChange: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomBotton(
                    text: 'LOGIN',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          await loginUser();
                          Navigator.pushNamed(context, ChatPage().id , arguments: email);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnakBar(context, 'user not exsit');
                          } else if (e.code == 'wrong-password') {
                            showSnakBar(context, 'wrong password');
                          }
                        } catch (e) {
                          showSnakBar(context, 'there was an error');
                        }
                        isLoading = false;
                        setState(() {});
                      } else {}
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'dont have an account? ',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                          ' Sign Up',
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
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
