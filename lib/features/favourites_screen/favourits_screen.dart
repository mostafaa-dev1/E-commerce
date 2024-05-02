import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:newww/components/components.dart';
import 'package:newww/components/constance.dart';
import 'package:newww/features/favourites_screen/model/favourites_model.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/logic/home_states.dart';
import 'package:newww/search/search_model.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Favourites',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ))),
            body: state is! GetFavouritesItemLoading
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => BuildFavItem(
                        ShopCubit.get(context)
                            .favouritesDataModel!
                            .data!
                            .data![index]
                            .productfav!,
                        context),
                    separatorBuilder: (context, index) => Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    itemCount: ShopCubit.get(context)
                        .favouritesDataModel!
                        .data!
                        .data!
                        .length,
                  )
                : Center(
                    child: Lottie.asset(
                      'lib/assets/images/loadingShop.json',
                      height: 200,
                      width: 200,
                    ),
                  ));
      },
    );
  }

  Widget BuildFavItem(ProductFav data, context) => Slidable(
        enabled: true,
        useTextDirection: true,
        startActionPane: ActionPane(
            motion: BehindMotion(),
            dismissible: DismissiblePane(onDismissed: () {}),
            dragDismissible: false,
            children: [
              SlidableAction(
                onPressed: (context) {
                  ShopCubit.get(context).ChangeFavourites(data.id!);
                },
                icon: Icons.delete,
                backgroundColor: Colors.red,
                label: 'Delete',
              ),
              SlidableAction(
                onPressed: (context) {
                  //ShopCubit.get(context).deleteFavourites(data.id!);
                },
                icon: Icons.shopping_cart_rounded,
                backgroundColor: color,
                label: 'Add To Cart',
              ),
            ]),
        child: Container(
          padding: EdgeInsets.all(10),
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Image(
                    image: NetworkImage(data.image!),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                  if (data.discount! != 0)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Text(
                        'Offer',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    )
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.orangeAccent,
                        ),
                        Text('4.5'),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          '\$${data.price.toString()}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (data.discount != 0)
                          Text(
                            data.oldPrice.toString(),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            CupertinoIcons.cart_fill_badge_plus,
                            color: color,
                            size: 27,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
