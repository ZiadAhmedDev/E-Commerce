import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/shop%20app/register/cubit/register_cubit.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/components/constants.dart';

import '../../../layout/shop_layout/cubit/shop_cubit.dart';
import 'cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Key? formKey = GlobalKey<FormState>();
    TextEditingController searchController = TextEditingController();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          validate: ((String? value) {
                            if (value!.isEmpty) {
                              return 'Type anything in search field';
                            } else {
                              return null;
                            }
                          }),
                          // onChange: ((value) {
                          //   SearchCubit.get(context).searchProduct(text: value);
                          //   printFullText(value);
                          // }),
                          onSubmit: (String value) {
                            SearchCubit.get(context).searchProduct(value);
                            printFullText(value.toString());
                          },
                          label: 'Search',
                          prefix: Icons.search),
                      const SizedBox(
                        height: 20,
                      ),
                      if (state is SearchLoading)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      if (state is SearchSuccess)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) =>
                                  listProductsBuilder(
                                      SearchCubit.get(context)
                                          .model!
                                          .data!
                                          .data![index],
                                      context,
                                      isOldPrice: false),
                              separatorBuilder: ((context, index) =>
                                  listDivider()),
                              itemCount: SearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data!
                                  .length),
                        )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
