part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopChangeScreen extends ShopState {}

class ShopLoadingHomeDataScreen extends ShopState {}

class ShopSuccessHomeDataScreen extends ShopState {}

class ShopErrorHomeDataScreen extends ShopState {
  final String? error;
  ShopErrorHomeDataScreen(this.error);
}

class ShopSuccessCategoryDataScreen extends ShopState {}

class ShopErrorCategoryDataScreen extends ShopState {
  final String? error;
  ShopErrorCategoryDataScreen(this.error);
}

class ShopSuccessChangeFavoriteDataScreen extends ShopState {
  final ChangeFavoriteModel? model;
  ShopSuccessChangeFavoriteDataScreen(this.model);
}

class ShopSuccessFavoriteDataScreen extends ShopState {}

class ShopErrorFavoriteDataScreen extends ShopState {
  final String? error;
  ShopErrorFavoriteDataScreen(this.error);
}

class ShopLoadingGetFavoriteDataScreen extends ShopState {}

class ShopSuccessGetFavoriteDataScreen extends ShopState {}

class ShopErrorGetFavoriteDataScreen extends ShopState {
  final String? error;
  ShopErrorGetFavoriteDataScreen(this.error);
}
class ThemeChange extends ShopState {}

class ShopLoadingGetSettingDataScreen extends ShopState {}

class ShopSuccessGetSettingDataScreen extends ShopState {
  LoginModel? profileData;
  ShopSuccessGetSettingDataScreen(this.profileData);
}

class ShopErrorGetSettingDataScreen extends ShopState {
  final String? error;
  ShopErrorGetSettingDataScreen(this.error);
}

class ShopLoadingUpdateUserDataScreen extends ShopState {}

class ShopSuccessUpdateUserDataScreen extends ShopState {
  LoginModel? profileData;
  ShopSuccessUpdateUserDataScreen(this.profileData);
}

class ShopErrorUpdateUserDataScreen extends ShopState {
  final String? error;
  ShopErrorUpdateUserDataScreen(this.error);
}

class ShopChangeSettingData extends ShopState {}

class ShopSaveSettingData extends ShopState {}
