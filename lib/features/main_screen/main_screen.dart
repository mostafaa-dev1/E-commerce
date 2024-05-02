import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newww/components/constance.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/logic/home_states.dart';

import '../cart_screen/cart_screen.dart';
import '../favourites_screen/favourits_screen.dart';
import '../home_screen/home_screen.dart';
import '../settings_screen/settings_screen.dart';

class ShopLayout extends StatefulWidget {
  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  List<Widget> Screens = [
    ProductsScreen(),
    CartScreen(),
    FavouritesScreen(),
    SettengsScreen()
  ];
  int CurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          body: Screens[CurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                CurrentIndex = index;
              });
              if (index == 3) {
                cubit.GetUserData();
              }
              if (index == 2) {
                cubit.GetFavouritesData();
              }
              if (index == 1) {
                cubit.total();
              }
            },
            selectedItemColor: color,
            currentIndex: CurrentIndex,
            items: cubit.BottomNavIcons,
          ),
        );
      },
    );
  }
}
