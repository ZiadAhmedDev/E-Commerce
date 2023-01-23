part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  LoginModel loginModel;
  RegisterSuccess(this.loginModel);
}

class RegisterError extends RegisterState {
  final String error;

  RegisterError(this.error);
}

class ChangeRegisterPasswordVisibility extends RegisterState {}
