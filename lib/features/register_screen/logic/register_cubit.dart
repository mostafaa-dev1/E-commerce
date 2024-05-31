import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newww/core/network/dio_helper/dio_helper.dart';
import 'package:newww/core/network/end_point.dart';
import 'package:newww/features/register_screen/logic/register_states.dart';
import 'package:newww/user_model/user_model.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterSates> {
  ShopRegisterCubit() : super(RegisterInitialstate());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  shopLoginModel? loginModel;

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(RegisterLoadingstate());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value?.data);
      loginModel = shopLoginModel.fromjson(value?.data);
      emit(RegisterSucssefullystate(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorstate(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isVisiable = true;
  void IsSufixPressed() {
    isVisiable = !isVisiable;
    suffix =
        isVisiable ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(sufixIconRegisterstate());
  }
}
