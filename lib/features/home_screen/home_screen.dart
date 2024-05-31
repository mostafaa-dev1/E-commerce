import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:newww/core/categories_model/categories_model.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/logic/home_states.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/core/theming/fonts.dart';
import 'package:newww/features/home_screen/model/home_model.dart';
import 'package:newww/features/home_screen/widgets/banners.dart';
import 'package:newww/features/home_screen/widgets/categories_item.dart';
import 'package:newww/features/home_screen/widgets/location.dart';
import 'package:newww/features/home_screen/widgets/product_item.dart';
import 'package:newww/search/search_screen.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is GetFavouritesSuccessfuly) {
          if (!state.model.status!) {
            showToast(
              state.model.message!,
              context: context,
              backgroundColor: AppColors.primaryColor,
              textStyle: AppFonts.style16,
              animation: StyledToastAnimation.slideFromBottom,
            );
          } else {
            showToast(
              state.model.message!,
              context: context,
              backgroundColor: AppColors.primaryColor,
              textStyle: AppFonts.style16,
              animation: StyledToastAnimation.slideFromBottom,
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromARGB(249, 246, 246, 246),
          body: ShopCubit.get(context).homeModel != null &&
                  ShopCubit.get(context).categoriesModel != null
              ? ProductsBuilder()
              : Center(
                  child: SizedBox(
                  height: 50,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballPulse,
                    colors: [AppColors.primaryColor],
                    strokeWidth: 2,
                  ),
                )),
        );
      },
    );
  }
}

Widget ProductsBuilder() => SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
              floating: true,
              expandedHeight: 80,
              collapsedHeight: 80,
              flexibleSpace: Location()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Banners(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Categories ', style: AppFonts.style28B),
                          TextButton(
                              onPressed: () {},
                              child: Text('See All',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 16,
                                  )))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CategoriesItem(),
                      Text(
                        'New Feed',
                        style: AppFonts.style28B,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  const ProductItem(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
