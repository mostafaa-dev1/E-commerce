import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:newww/features/cart_screen/cart_screen.dart';
import 'package:newww/features/favourites_screen/favourits_screen.dart';
import 'package:newww/features/home_screen/home_screen.dart';
import 'package:newww/features/settings_screen/settings_screen.dart';
import 'package:newww/categories_model/categories_model.dart';
import 'package:newww/components/constance.dart';
import 'package:newww/core/network/dio_helper/dio_helper.dart';
import 'package:newww/features/favourites_screen/model/favourites_model.dart';
import 'package:newww/core/logic/home_states.dart';
import 'package:flutter/material.dart';
import 'package:newww/features/home_screen/model/home_model.dart';
import 'package:newww/core/network/end_point.dart';
import 'package:newww/user_model/user_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> BottomNavIcons = [
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Home,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Buy,
      ),
      label: 'Cart',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Heart,
      ),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Setting,
      ),
      label: 'Settings',
    ),
  ];

  HomeModel? homeModel;
  HomeDataModel? homeDataModel;
  Map<int, bool> favourites = {};
  List<dynamic> data = [];
  Future<void> GetHomeData() async {
    emit(LoadingHomeScreen());
    await DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
      homeModel!.data!.products.forEach((element) {
        favourites.addAll({element.id!: element.inFavourites!});
      });
      data.add(value!.data['data']['products']);
      //print(value!.data['data']['products']);
      emit(GetDataSuccessfuly());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetDataError());
    });
  }

  CategoriesModel? categoriesModel;
  void GetCategoriesData() {
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      emit(GetCatDataSuccessfuly());
      categoriesModel = CategoriesModel.fromjson(value?.data);
      // print(categoriesModel.toString());
      // print(categoriesModel!.status);
    }).catchError((onError) {
      print(onError.toString());
      emit(GetCatDataError());
    });
  }

  List<dynamic> favouritesData = [];
  FavouritesModel? favouritesModel;
  void ChangeFavourites(int id) {
    emit(ChangeFavouritesData());
    favourites[id] = !favourites[id]!;
    DioHelper.postData(url: FAVOURITES, data: {'product_id': id}, token: token)
        .then((value) {
      favouritesModel = FavouritesModel.fromJson(value!.data);
      print(value.data);
      if (!favouritesModel!.status!) {
        favourites[id] = !favourites[id]!;
      } else {
        GetFavouritesData();
      }
      emit(GetFavouritesSuccessfuly(favouritesModel!));
    }).catchError((error) {
      favourites[id] = !favourites[id]!;
      emit(GetFavouritesDataError());
    });
  }

  FavouritesDataModel? favouritesDataModel;

  void GetFavouritesData() {
    favouritesData = [];
    emit(GetFavouritesItemLoading());
    DioHelper.getData(url: FAVOURITES, token: token).then((value) {
      emit(GetFavouritesItemSuccess());

      // favouritesData.add(value?.data['data']['data'][0]['product']);
      // favouritesData.forEach((element) {
      //   print(element);
      // });

      print(value?.data);
    }).catchError((onError) {
      print(onError.toString());
      emit(GetFavouritesItemError());
    });
  }

  shopLoginModel? userData;

  void GetUserData() {
    emit(GetUserDataLoading());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      emit(GetUserDataSuccess());
      userData = shopLoginModel.fromjson(value?.data);
      print(userData!.data!.name);
    }).catchError((onError) {
      print(onError.toString());
      emit(GetUserDataError());
    });
  }

  List<Map<String, String>> categories = [
    {
      'name': 'Electronics',
      'image': 'lib/assets/images/electronics.png',
    },
    {
      'name': 'Games',
      'image': 'lib/assets/images/joystick.png',
    },
    {
      'name': 'Devices',
      'image': 'lib/assets/images/device.png',
    },
    {
      'name': 'Cameras',
      'image': 'lib/assets/images/gadget.png',
    },
    {
      'name': 'Accessories',
      'image': 'lib/assets/images/gadgets.png',
    }
  ];

  List<Map<String, dynamic>> cart = [];
  double? totalPrice = 0;
  void total() {
    totalPrice = 0;
    emit(TotalPrice());
    if (cart.isNotEmpty) {
      cart.forEach((element) {
        totalPrice = totalPrice! + element['total'];
      });
    }
  }
}
