part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginFaliure extends AuthState {
  final String errMessage;

  LoginFaliure(this.errMessage);
}

final class RegisterInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterFailure extends AuthState {
  final String errMessage;

  RegisterFailure(this.errMessage);
}
