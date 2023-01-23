import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/layout/shop_layout/cubit/shop_cubit.dart';
import 'package:news_app/models/search.dart';
import 'package:news_app/shared/components/constants.dart';
import 'package:news_app/shared/network/endpoints.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void searchProduct(String? text) {
    emit(SearchLoading());
    DioHelper.postData(
      url: searchEndpoint,
      data: {'text': text},
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      printFullText(value.data.toString());
      model = SearchModel.fromJson(value.data);
      // ShopCubit.get(context).getFavoriteData;
      emit(SearchSuccess());
    }).catchError((onError) {
      printFullText(onError.toString());
      emit(SearchError(onError.toString()));
    });
  }
}
