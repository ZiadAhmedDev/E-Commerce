import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/favorite.dart';
import 'package:news_app/shared/components/components.dart';
import '../../../layout/shop_layout/cubit/shop_cubit.dart';
import '../../../shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) => ListView.separated(
            itemBuilder: ((context, index) => listProductsBuilder(
                ShopCubit.get(context)
                    .favoriteModel!
                    .data!
                    .data![index]
                    .product,
                context)),
            separatorBuilder: ((context, index) => listDivider()),
            itemCount:
                ShopCubit.get(context).favoriteModel!.data!.data!.length));
  }
}
