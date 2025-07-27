part of 'login_cubit_cubit.dart';

@immutable
sealed class LoginCubitState {}

final class LoginCubitInitial extends LoginCubitState {}

final class LoginCubitLoading extends LoginCubitState {}

final class LoginCubitSuccess extends LoginCubitState {}

final class LoginCubitFailure extends LoginCubitState {
  final String errMessage;

  LoginCubitFailure(this.errMessage);
}
