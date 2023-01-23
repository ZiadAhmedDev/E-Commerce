import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/categories.dart';
import 'package:news_app/models/favorite.dart';

import 'package:news_app/models/home_model.dart';
import 'package:news_app/modules/shop%20app/categories/categories_screen.dart';
import 'package:news_app/modules/shop%20app/favorites/favorites_screen.dart';
import 'package:news_app/modules/shop%20app/products/product_screen.dart';
import 'package:news_app/modules/shop%20app/settings/settings_screen.dart';
import 'package:news_app/shared/network/endpoints.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import '../../../models/change_favorite.dart';

import '../../../models/login_model.dart';
import '../../../shared/components/constants.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen = [
    const ProductScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    SettingScreen(),
  ];

  void changeScreenIndex(int index) {
    currentIndex = index;
    emit(ShopChangeScreen());
  }

  Map<int?, bool?> favorite = {};
  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataScreen());
    DioHelper.getData(
            url: homeEndpoint, token: CacheHelper.getData(key: 'token'))
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data!.products
          .forEach((e) => favorite.addAll({e.id: e.inFavorites}));
      print('$favorite');
      emit(ShopSuccessHomeDataScreen());
      // printFullText(homeModel!.status.toString());
    }).catchError((onError) {
      emit(ShopErrorHomeDataScreen(onError.toString()));
      printFullText(onError.toString());
    });
  }

  bool isDark = false;

  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ThemeChange());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ThemeChange());
      });
    }
  }

  CategoryModel? categoryModel;
  void getCategoryData() {
    emit(ShopLoadingHomeDataScreen());
    DioHelper.getData(url: categoryEndpoint).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopSuccessCategoryDataScreen());
      // printFullText(categoryModel?.data!.data.toString());
    }).catchError((onError) {
      emit(ShopErrorCategoryDataScreen(onError.toString()));
      printFullText(onError.toString());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;
  void addDeleteFavoriteData(int productId) {
    favorite[productId] = !favorite[productId]!;
    emit(ShopSuccessChangeFavoriteDataScreen(changeFavoriteModel));
    DioHelper.postData(
            url: favoriteEndpoint,
            data: {'product_id': productId},
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      // printFullText(value.data.toString());
      if (changeFavoriteModel?.status == false) {
        favorite[productId] = !favorite[productId]!;
      } else {
        getFavoriteData();
      }
      emit(ShopSuccessFavoriteDataScreen());
    }).catchError((onError) {
      favorite[productId] = !favorite[productId]!;
      emit(ShopErrorFavoriteDataScreen(onError.toString()));
      printFullText(onError.toString());
    });
  }

  FavoriteModel? favoriteModel;
  // Set<int?>? favoriteList ={};
  void getFavoriteData() {
    emit(ShopLoadingGetSettingDataScreen());
    DioHelper.getData(url: favoriteEndpoint).then((value) {
      // favoriteList!.clear();
      favoriteModel = FavoriteModel.fromJson(value.data);
      // favoriteModel!.data!.data!.forEach((element) {
      //   favoriteList!.add(element.id);
      // });
      emit(ShopSuccessGetFavoriteDataScreen());
    }).catchError((onError) {
      emit(ShopErrorGetFavoriteDataScreen(onError.toString()));
      printFullText(onError.toString());
    });
  }

  LoginModel? profileData;
  void getSettingData() {
    emit(ShopLoadingGetSettingDataScreen());
    DioHelper.getData(
      url: profileEndpoint,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      printFullText(token);
      profileData = LoginModel.fromJson(value.data);
      emit(ShopSuccessGetSettingDataScreen(profileData!));
      printFullText(profileData!.data!.name.toString());
    }).catchError((onError) {
      emit(ShopErrorGetSettingDataScreen(onError.toString()));
      printFullText(onError.toString());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserDataScreen());
    DioHelper.putData(
      url: updateEndpoint,
      data: {'name': name, 'email': email, 'phone': phone},
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      profileData = LoginModel.fromJson(value.data);
      saveSettingData();
      printFullText(profileData!.data!.name.toString());
      emit(ShopSuccessUpdateUserDataScreen(profileData!));
    }).catchError((onError) {
      printFullText(onError.toString());
      emit(ShopErrorUpdateUserDataScreen(onError.toString()));
    });
  }

  bool isEditable = false;
  void changeSettingData() {
    isEditable = true;
    emit(ShopChangeSettingData());
  }

  void saveSettingData() async {
    isEditable = false;
    emit(ShopChangeSettingData());
  }
}
