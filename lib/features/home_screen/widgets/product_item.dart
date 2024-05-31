import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/core/theming/fonts.dart';
import 'package:newww/features/home_screen/widgets/item_veiw.dart';
import 'package:page_transition/page_transition.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  int? currentIndex;
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: .6,
      ),
      itemCount: ShopCubit.get(context).data[0].length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var item = ShopCubit.get(context).data[0][index];
        var model = ShopCubit.get(context).homeModel!;
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    child: ViewItem(
                      id: item['id'],
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
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200]!,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item['name'].toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppFonts.style16),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('\$${item['price'].toString()}',
                                style: AppFonts.style18),
                            const SizedBox(
                              width: 5,
                            ),
                            if (item['discount'] != 0)
                              Text('\$${item['old_price'].toString()}',
                                  style: AppFonts.style13),
                            const Spacer(),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ShopCubit.get(context).ChangeFavourites(
                                        model.data!.products[index].id!);
                                    print(model.data!.products[index].id!);
                                  });

                                  //print(model.data!.products[widget.index].id);
                                },
                                child: Icon(
                                  ShopCubit.get(context).favourites[model
                                              .data!.products[index].id!]! ||
                                          currentIndex == index
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  color: ShopCubit.get(context).favourites[model
                                              .data!.products[index].id!]! ||
                                          currentIndex == index
                                      ? AppColors.primaryColor
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
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Offer',
                      style: AppFonts.style14wB,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
