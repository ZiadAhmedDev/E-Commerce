import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:news_app/models/categories.dart';
import 'package:news_app/shared/components/components.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var category = ShopCubit.get(context).categoryModel!.data!.data;
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((context, index) => categoryItem(category[index])),
            separatorBuilder: ((context, index) => listDivider()),
            itemCount: category!.length);
      },
    );
  }
}

Widget categoryItem(DataModel dataCategory) => Row(
      children: [
        Image(
          image: NetworkImage('${dataCategory.image}'),
          width: 120,
          height: 120,
        ),
        Text(
          '   ${dataCategory.name}',
          style: const TextStyle(fontSize: 18),
        ),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
      ],
    );
