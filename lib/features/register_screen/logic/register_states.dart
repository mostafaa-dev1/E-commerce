import 'package:newww/user_model/user_model.dart';

abstract class ShopRegisterSates {}

class RegisterInitialstate extends ShopRegisterSates {}

class RegisterSucssefullystate extends ShopRegisterSates {
  final shopLoginModel loginModel;

  RegisterSucssefullystate(this.loginModel);
}

class RegisterErrorstate extends ShopRegisterSates {
  final String error;

  RegisterErrorstate(this.error);
}

class RegisterLoadingstate extends ShopRegisterSates {}

class sufixIconRegisterstate extends ShopRegisterSates {}
