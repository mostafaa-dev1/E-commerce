import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/core/theming/fonts.dart';
import 'package:newww/features/home_screen/widgets/item_veiw.dart';
import 'package:newww/search/logic/cubit.dart';
import 'package:newww/search/search_model.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => BuildSearchItem(
          SearchCubit.get(context).searchModel!.data!.data![index], context),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: SearchCubit.get(context).searchModel!.data!.data!.length,
    ));
  }
}

Widget BuildSearchItem(Product data, context) => GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewItem(
                    id: data.id!,
                    image: data.image!,
                    text: data.name.toString(),
                    price: data.price,
                    description: data.description!,
                    discount: 0)));
      },
      child: Stack(
        children: [
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200]!,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Image(
                  image: NetworkImage(data.image!),
                  height: 120,
                  width: 120,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
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
                                    text: '${data.price}',
                                    style: AppFonts.style18.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
                                  'id': data.id,
                                  'name': data.name,
                                  'price': data.price,
                                  'image': data.image,
                                  'discount': 0,
                                  'quantity': 1,
                                  'old_price': data.oldPrice,
                                  'total': data.price,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                ShopCubit.get(context).ChangeFavourites(data.id!);
              },
              child: Icon(
                ShopCubit.get(context).favourites[data.id]! ?? false
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart,
                color: ShopCubit.get(context).favourites[data.id]!
                    ? AppColors.primaryColor
                    : Colors.black,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
