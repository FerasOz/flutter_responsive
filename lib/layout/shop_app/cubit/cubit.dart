import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project_flutter/layout/shop_app/cubit/states.dart';
import 'package:new_project_flutter/models/shop_app/categories/categories_model.dart';
import 'package:new_project_flutter/models/shop_app/favorites/change_favourites_model.dart';
import 'package:new_project_flutter/models/shop_app/favorites/favourites_model.dart';
import 'package:new_project_flutter/models/shop_app/home/home_model.dart';
import 'package:new_project_flutter/models/shop_app/login/login_model.dart';
import 'package:new_project_flutter/modules/shop_app/categories/categories_screen.dart';
import 'package:new_project_flutter/modules/shop_app/favorites/favorites_screen.dart';
import 'package:new_project_flutter/modules/shop_app/products/products_screen.dart';
import 'package:new_project_flutter/modules/shop_app/settings/settings_screen.dart';
import 'package:new_project_flutter/shared/components/constants.dart';
import 'package:new_project_flutter/shared/network/end_point.dart';
import 'package:new_project_flutter/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  Map<int, bool> favourites = {};

  List<Widget> bottomScreens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      print(homeModel!.status);

      homeModel!.data!.products.forEach((element) {
        favourites.addAll({
          element.id: element.in_favorites,
        });
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoData() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      print(categoriesModel!.status);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;

  void changeFavourites(int productID) {
    favourites[productID] = !favourites[productID]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
            url: FAVOURITES, data: {'product_id': productID}, token: token)
        .then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);

      if (!changeFavouritesModel!.status!) {
        favourites[productID] = !favourites[productID]!;
      } else {
        getFavourites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavouritesModel!));
    }).catchError((error) {
      print(error.toString());
      favourites[productID] = !favourites[productID]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavouritesModel? favouritesModel;

  void getFavourites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(url: GET_FAVOURITES, token: token).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      print(favouritesModel.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {
          'name' : name,
          'email' : email,
          'phone' : phone,
        }
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
