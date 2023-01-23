import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/login_model.dart';
import 'package:news_app/shared/network/endpoints.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(RegisterLoading());
    DioHelper.postData(
      url: registerEndpoint,
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);

      emit(RegisterSuccess(loginModel!));
    }).catchError((error) {
      emit(RegisterError(error.toString()));
    });
  }

  bool isPassword = true;
  IconData iconSuffix = Icons.visibility_outlined;

  void passwordVisibility() {
    isPassword = !isPassword;
    iconSuffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordVisibility());
  }
}
