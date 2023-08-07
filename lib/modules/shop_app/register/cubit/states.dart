import '../../../../models/shop_app/login/login_model.dart';

abstract class ShopRegisterStates{}

class ShopRegisterInitialState extends ShopRegisterStates{}

class ShopRegisterLoadingState extends ShopRegisterStates{}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates{}

class ShopRegisterSuccessState extends ShopRegisterStates{
  final ShopLoginModel RegisterModel;

  ShopRegisterSuccessState(this.RegisterModel);
}

class ShopRegisterErrorState extends ShopRegisterStates{
  final error;

  ShopRegisterErrorState(this.error);
}
