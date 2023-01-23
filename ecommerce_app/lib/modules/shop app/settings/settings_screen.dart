import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/components/constants.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var profile = ShopCubit.get(context).profileData;
        nameController.text = profile!.data!.name!;
        emailController.text = profile.data!.email!;
        phoneController.text = profile.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).profileData != null,
          builder: ((context) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state is ShopLoadingUpdateUserDataScreen)
                            const LinearProgressIndicator(),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 370,
                                child: defaultFormField(
                                  controller: nameController,
                                  type: TextInputType.name,
                                  isEditable: ShopCubit.get(context).isEditable,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'Name field can\'t be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  label: 'Full Name',
                                  labelStyle: TextStyle(
                                      fontSize: 20, color: Colors.grey[600]),
                                  prefix: Icons.person,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 370,
                                child: defaultFormField(
                                  controller: emailController,
                                  type: TextInputType.emailAddress,
                                  isEditable: ShopCubit.get(context).isEditable,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'emailAddress field can\'t be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  label: 'Email Address',
                                  labelStyle: TextStyle(
                                      fontSize: 20, color: Colors.grey[600]),
                                  prefix: Icons.email_outlined,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 370,
                                child: defaultFormField(
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  isEditable: ShopCubit.get(context).isEditable,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'phone field can\'t be empty';
                                    } else {
                                      return null;
                                    }
                                  },
                                  label: 'Phone',
                                  labelStyle: TextStyle(
                                      fontSize: 20, color: Colors.grey[600]),
                                  prefix: Icons.phone,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 50,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[500],
                                  ),
                                  width: 100,
                                  child: IconButton(
                                    onPressed: () {
                                      ShopCubit.get(context)
                                          .changeSettingData();
                                    },
                                    icon: const Icon(
                                      (Icons.edit),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey[500],
                                  ),
                                  width: 100,
                                  child: IconButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        ShopCubit.get(context).updateUserData(
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text);
                                      }
                                    },
                                    icon: const Icon(
                                      (Icons.check),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultButton(
                              function: () => signOut(context),
                              text: 'SignOut',
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(
                            height: 20,
                          ),
                        ]),
                  ),
                ),
              )),
          fallback: ((context) => const Center(
                child: CircularProgressIndicator(),
              )),
        );
      },
    );
  }
}
