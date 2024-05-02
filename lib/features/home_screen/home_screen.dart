import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:lottie/lottie.dart';
import 'package:newww/categories_model/categories_model.dart';
import 'package:newww/components/components.dart';
import 'package:newww/components/constance.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/logic/home_states.dart';
import 'package:newww/features/home_screen/model/home_model.dart';
import 'package:page_transition/page_transition.dart';

import 'widgets/item_veiw.dart';

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
              animation: StyledToastAnimation.slideFromBottom,
            );
          } else {
            showToast(
              state.model.message!,
              context: context,
              animation: StyledToastAnimation.slideFromBottom,
            );
          }
        }
      },
      builder: (context, state) {
        return ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null
            ? ProductsBuilder(ShopCubit.get(context).homeModel!,
                ShopCubit.get(context).categoriesModel!, context)
            : Center(
                child: Lottie.asset(
                  'lib/assets/images/loadingShop.json',
                  height: 200,
                  width: 200,
                ),
              );
      },
    );
  }
}

Widget ProductsBuilder(
        HomeModel model, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Location',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                        SizedBox(height: 2),
                        Row(children: [
                          Icon(
                            Icons.location_on,
                            color: color,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          const Text('Egypt,Cairo',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ))
                        ])
                      ],
                    ),
                    Icon(
                      IconBroken.Notification,
                      color: color,
                    )
                  ]),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 250,
                child: Swiper(
                    itemCount: model.data!.banners.length,
                    autoplay: true,
                    pagination: SwiperPagination(builder:
                        SwiperCustomPagination(builder:
                            (BuildContext context, SwiperPluginConfig config) {
                      return Container(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                model.data!.banners.length,
                                (index) => Container(
                                  margin: const EdgeInsets.all(3),
                                  width: 15,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: config.activeIndex == index
                                        ? color
                                        : color.withOpacity(0.2),
                                  ),
                                ),
                              )));
                    })),
                    outer: true,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Image(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  '${model.data!.banners[index].image}'),
                            ),
                          ),
                        )),
              ),
              // CarouselSlider(
              //     items: model.data!.banners.map((e) => Image(
              //       image: NetworkImage('${e.image}'),
              //       fit: BoxFit.cover,
              //       width: double.infinity,
              //
              //     ),).toList(),
              //
              //     options: CarouselOptions(
              //       height: 250,
              //       initialPage: 0,
              //       enableInfiniteScroll: true,
              //       reverse: false,
              //       autoPlay: true,
              //       autoPlayInterval: const Duration(seconds: 3),
              //       autoPlayAnimationDuration: const Duration(seconds: 1),
              //       autoPlayCurve: Curves.fastOutSlowIn,
              //
              //       scrollDirection: Axis.horizontal,
              //
              //       viewportFraction: 1,
              //
              //     )
              //
              // ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text('See All',
                              style: TextStyle(
                                color: color,
                                fontSize: 16,
                              )))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 170,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CategoriesItem(
                          categoriesModel.data!.categories![index],
                          ShopCubit.get(context).categories[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: ShopCubit.get(context).categories.length,
                    ),
                  ),
                  const Text(
                    'New Feed',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: .5,
                ),
                itemCount: ShopCubit.get(context).data[0].length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = ShopCubit.get(context).data[0][index];

                  return GestureDetector(
                    onTap: () {
                      print(model.data!.products[index]);
                      Navigator.push(
                          context,
                          PageTransition(
                              child: ViewItem(
                                description: item['description'],
                                image: item['image'],
                                text: item['name'],
                                price: item['price'],
                                discount: item['discount'],
                                oldPrice: item['old_price'],
                              ),
                              type: PageTransitionType.fade));
                    },
                    child: Stack(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300]!,
                                  blurRadius: 7,
                                  spreadRadius: 1,
                                )
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                image: NetworkImage(item['image']),
                                height: 200,
                                width: double.infinity,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item['name'].toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '\$${item['price'].toString()}',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: color,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      if (item['discount'] != 0)
                                        Text(
                                          '\$${item['old_price'].toString()}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      Spacer(),
                                      GestureDetector(
                                          onTap: () {
                                            ShopCubit.get(context)
                                                .ChangeFavourites(model
                                                    .data!.products[index].id!);
                                            print(
                                                model.data!.products[index].id);
                                          },
                                          child: Icon(
                                            model.data!.products[index]
                                                    .inFavourites!
                                                ? CupertinoIcons.heart_fill
                                                : CupertinoIcons.heart,
                                            color: model.data!.products[index]
                                                    .inFavourites!
                                                ? color
                                                : Colors.black,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (model.data!.products[index].discount != 0)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: const Text(
                                'Offer',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
Widget CategoriesItem(CategoriesData categoriesData, category) => Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Image(
                height: 40,
                image: AssetImage(category['image']),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          category['name'],
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
