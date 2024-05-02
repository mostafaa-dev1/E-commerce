import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newww/features/login_screen/logic/states.dart';
import 'package:newww/core/network/dio_helper/dio_helper.dart';
import 'package:newww/core/network/end_point.dart';
import 'package:newww/user_model/user_model.dart';

class ShopLoginCubit extends Cubit<ShopLoginSates> {
  ShopLoginCubit() : super(LoginInitialstate());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  shopLoginModel? loginModel;

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingstate());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      print(value?.data);
      loginModel = shopLoginModel.fromjson(value?.data);
      emit(LoginSucssefullystate(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorstate(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isVisiable = true;
  void IsSufixPressed() {
    isVisiable = !isVisiable;
    suffix =
        isVisiable ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(sufixIconstate());
  }
}
