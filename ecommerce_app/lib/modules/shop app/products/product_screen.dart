import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:news_app/models/categories.dart';
import 'package:news_app/models/home_model.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoriteDataScreen) {
          if (state.model?.status == false) {
            showToaster(
                message: state.model?.message ?? 'SomeThing go wrong',
                state: ToasterState.error);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoryModel != null,
          builder: ((context) => productBuilder(
              ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categoryModel,
              context)),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

Widget productBuilder(HomeModel? model, CategoryModel? catModel, context) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model?.data?.banners
              .map((e) => Image(
                    image: NetworkImage(e.image ??
                        'https://student.valuxapps.com/storage/uploads/categories/1630142480dvQxx.3658058.jpg'),
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ))
              .toList(),
          options: CarouselOptions(
            height: 200,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Category',
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 120,
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  categoryItems(catModel.data!.data![index]),
              separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
              itemCount: catModel!.data!.data!.length),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'New Product',
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.59,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(model!.data!.products.length,
                (index) => productItems(model.data!.products[index], context)),
          ),
        )
      ],
    ),
  );
}

Widget categoryItems(DataModel? catModel) => Stack(children: [
      SizedBox(
        height: 120,
        width: 120,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image(
              image: NetworkImage('${catModel?.image}'),
              fit: BoxFit.cover,
              height: 100,
              width: 120,
            ),
            Container(
              color: Colors.black.withOpacity(0.8),
              width: double.infinity,
              child: Text(
                '${catModel?.name}',
                maxLines: 1,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ]);

Widget productItems(HomeDataProduct product, context) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Stack(alignment: Alignment.bottomLeft, children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image(
              image: NetworkImage('${product.image}'),
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
          if (product.discount != 0)
            Container(
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'Discount',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                child: Text(
                  '${product.name}',
                  style: const TextStyle(fontSize: 14, height: 1.2),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${product.price?.round()} \$',
                    style: const TextStyle(
                        fontSize: 17, height: 1.2, color: defaultColor),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (product.discount != 0)
                    Text(
                      '${product.oldPrice?.round()} \$',
                      style: const TextStyle(
                          fontSize: 15,
                          height: 1.2,
                          color: Color.fromARGB(255, 121, 120, 120),
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor:
                          ShopCubit.get(context).favorite[product.id]!
                              ? Colors.red
                              : Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .addDeleteFavoriteData(product.id!);
                        },
                        icon: const Icon(
                          Icons.favorite_border_outlined,
                          size: 17,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
