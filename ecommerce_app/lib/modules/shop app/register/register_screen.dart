import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:news_app/layout/shop_layout/shop_layout.dart';
import 'package:news_app/modules/shop%20app/login/cubit/login_cubit.dart';
import 'package:news_app/modules/shop%20app/register/register_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

import '../../../shared/components/constants.dart';
import '../login/login_screen.dart';
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RegisterCubit(),
          ),
        ],
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) async {
            if (state is RegisterLoading) {
              const LinearProgressIndicator();
            }
            if (state is RegisterSuccess) {
              if (state.loginModel.status!) {
                print(state.loginModel.message);
                print(state.loginModel.data?.token);
                CacheHelper.saveData(
                        key: 'token', value: state.loginModel.data?.token)
                    .then((value) {
                  token = CacheHelper.getData(key: 'token');
                  navigateAndReplacement(context, const ShopLayout());
                });
              } else {
                showToaster(
                    message: state.loginModel.message!,
                    state: ToasterState.error);
              }
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('REGISTER',
                              style: Theme.of(context).textTheme.headline5),
                          Text('REGISTER now to browse our hot offers',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.grey)),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Name field can\'t be empty';
                                }
                                return null;
                              },
                              label: 'Full Name',
                              prefix: Icons.person),
                          const SizedBox(
                            height: 25,
                          ),
                          defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Phone field can\'t be empty';
                                }
                                return null;
                              },
                              label: 'Phone',
                              prefix: Icons.phone_android_rounded),
                          const SizedBox(
                            height: 25,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Email field can\'t be empty';
                                }
                                return null;
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined),
                          const SizedBox(
                            height: 25,
                          ),
                          defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              isPassword: RegisterCubit.get(context).isPassword,
                              suffix: RegisterCubit.get(context).iconSuffix,
                              suffixPressed: () {
                                RegisterCubit.get(context).passwordVisibility();
                              },
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'password field can\'t be empty';
                                }
                                return null;
                              },
                              label: 'Password',
                              prefix: Icons.lock_outlined),
                          const SizedBox(
                            height: 25,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterLoading,
                            builder: (context) => defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    RegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'register'),
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'I already have an account  ',
                                style: TextStyle(fontSize: 16),
                              ),
                              defaultTextButton(
                                function: () {
                                  navigateTo(context, LoginScreen());
                                },
                                text: 'LOGIN',
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
