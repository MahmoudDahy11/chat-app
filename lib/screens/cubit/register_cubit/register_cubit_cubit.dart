import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_cubit_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
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
