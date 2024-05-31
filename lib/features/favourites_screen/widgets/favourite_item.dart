import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/core/theming/fonts.dart';

class FaouriteItem extends StatelessWidget {
  const FaouriteItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) =>
          BuildFavItem(ShopCubit.get(context).favouritesData[index], context),
      separatorBuilder: (context, index) => Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
      itemCount: ShopCubit.get(context).favouritesData.length,
    );
  }
}

Widget BuildFavItem(data, context) => Slidable(
      enabled: true,
      useTextDirection: true,
      startActionPane: ActionPane(
          motion: const BehindMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          dragDismissible: false,
          children: [
            SlidableAction(
              onPressed: (context) {
                ShopCubit.get(context).ChangeFavourites(data['id']);
              },
              icon: IconBroken.Delete,
              backgroundColor: Colors.red,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {
                ShopCubit.get(context).addToCart({
                  'id': data['id'],
                  'name': data['name'],
                  'price': data['price'],
                  'image': data['image'],
                  'discount': data['discount'],
                  'quantity': 1,
                  'old_price': data['old_price'],
                  'total': data['price'],
                });
              },
              icon: IconBroken.Buy,
              backgroundColor: AppColors.primaryColor,
              label: 'Add To Cart',
            ),
          ]),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 120,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Image(
                  image: NetworkImage(data['image'].toString()),
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
                if (data['discount'] != 0)
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
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['name'].toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.style16,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: '\$',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                                text: data['price'].toString(),
                                style: AppFonts.style20B),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (data['discount'] != 0)
                        Text(
                          data['old_price'].toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            ShopCubit.get(context).addToCart({
                              'id': data['id'],
                              'name': data['name'],
                              'price': data['price'],
                              'image': data['image'],
                              'discount': data['discount'],
                              'quantity': 1,
                              'old_price': data['old_price'],
                              'total': data['price'],
                            });
                          },
                          child: Text('Add to cart',
                              style: AppFonts.style16
                                  .copyWith(color: Colors.white))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
