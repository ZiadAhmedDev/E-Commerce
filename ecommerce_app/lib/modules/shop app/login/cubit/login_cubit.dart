import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/login_model.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/endpoints.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

import '../../register/cubit/register_cubit.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;
  void userLogin({required String email, required String password}) {
    emit(LoginLoading());
    DioHelper.postData(
      url: loginEndpoint,
      data: {'email': email, 'password': password},
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      token = loginModel!.data!.token!;
      emit(LoginSuccess(loginModel!));
    }).catchError((error) {
      emit(LoginError(error.toString()));
    });
  }

  bool isPassword = true;
  IconData iconSuffix = Icons.visibility_outlined;

  void passwordVisibility() {
    isPassword = !isPassword;
    iconSuffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibility());
  }
}
