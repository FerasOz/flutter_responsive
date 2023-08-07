import 'package:new_project_flutter/models/shop_app/favorites/change_favourites_model.dart';
import 'package:new_project_flutter/models/shop_app/login/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{

  final ChangeFavouritesModel  model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopChangeFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}


class ShopErrorGetFavoritesState extends ShopStates{}

class ShopSuccessGetUserDataState extends ShopStates{

  final ShopLoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);

}

class ShopLoadingGetUserDataState extends ShopStates{}


class ShopErrorGetUserDataState extends ShopStates{}


class ShopSuccessUpdateUserDataState extends ShopStates{

  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);

}

class ShopLoadingUpdateUserDataState extends ShopStates{}


class ShopErrorUpdateUserDataState extends ShopStates{}
