import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/logic/home_states.dart';
import 'package:newww/core/theming/fonts.dart';
import 'package:newww/features/favourites_screen/widgets/favourite_item.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              centerTitle: true,
              title: Text('Favourites', style: AppFonts.style28B),
            ),
            body: state is GetFavouritesItemLoading ||
                    state is ChangeFavouritesData
                ? Center(
                    child: SizedBox(
                    height: 50,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballPulse,
                      colors: [AppColors.primaryColor],
                      strokeWidth: 2,
                    ),
                  ))
                : FaouriteItem());
      },
    );
  }
}
