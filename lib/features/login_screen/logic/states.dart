import 'package:newww/user_model/user_model.dart';

abstract class ShopLoginSates {}

class LoginInitialstate extends ShopLoginSates {}

class LoginSucssefullystate extends ShopLoginSates {
  final shopLoginModel loginModel;

  LoginSucssefullystate(this.loginModel);
}

class LoginErrorstate extends ShopLoginSates {
  final String error;

  LoginErrorstate(this.error);
}

class LoginLoadingstate extends ShopLoginSates {}

class sufixIconstate extends ShopLoginSates {}
