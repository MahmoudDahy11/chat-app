import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
 
    Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFaliure(e.toString()));
      } else if (e.code == 'wrong-password') {
        emit(LoginFaliure(e.toString()));
      }
    } catch (e) {
      emit(LoginFaliure(e.toString()));
    }
  }
  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    var auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    emit(RegisterLoading());
    try {
      // ignore: unused_local_variable
      UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(e.toString()));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(e.toString()));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
  
}
