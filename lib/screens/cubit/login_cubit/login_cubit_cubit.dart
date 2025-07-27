import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_cubit_state.dart';

class LoginCubitCubit extends Cubit<LoginCubitState> {
  LoginCubitCubit() : super(LoginCubitInitial());
    Future<void> loginUser({required String email , required String password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
