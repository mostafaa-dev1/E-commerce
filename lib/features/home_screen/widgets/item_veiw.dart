import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:newww/components/constance.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/core/theming/fonts.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

class ViewItem extends StatefulWidget {
  const ViewItem({
    super.key,
    required this.image,
    required this.text,
    required this.price,
    required this.description,
    required this.discount,
    this.oldPrice,
    required this.id,
  });
  final String image;
  final String text;
  final dynamic price;
  final String description;
  final dynamic discount;
  final dynamic oldPrice;
  final int id;

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  @override
  int quantity = 1;
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 350,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.image,
                fit: BoxFit.scaleDown,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300]!,
                            blurRadius: 7,
                            spreadRadius: 1,
                          )
                        ]),
                    child: const Center(
                      child: Icon(CupertinoIcons.heart),
                    )),
              ),
            ],
            leadingWidth: 60,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300]!,
                          blurRadius: 7,
                          spreadRadius: 1,
                        )
                      ]),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('\$${widget.price}', style: AppFonts.style20B),
                      widget.discount != 0
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '\$${widget.oldPrice.toString()}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            )
                          : Container(),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orangeAccent,
                          ),
                          Text('4.5', style: AppFonts.style16)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.text, style: AppFonts.style20w600),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20)),
                        child: StepperSwipe(
                          initialValue: quantity,
                          iconsColor: AppColors.primaryColor,

                          speedTransitionLimitCount:
                              3, //Trigger count for fast counting
                          onChanged: (int value) {
                            setState(() {
                              quantity = value;
                            });
                          },
                          firstIncrementDuration: const Duration(
                              milliseconds:
                                  250), //Unit time before fast counting
                          secondIncrementDuration: const Duration(
                              milliseconds:
                                  100), //Unit time during fast counting
                          direction: Axis.horizontal,
                          dragButtonColor: AppColors.primaryColor,
                          maxValue: 10,
                          minValue: 1,
                          stepperValue: quantity,
                        ),
                      ),
                      Spacer(),
                      Text.rich(TextSpan(
                        children: [
                          TextSpan(
                              text: 'Total : ',
                              style: AppFonts.style20
                                  .copyWith(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: '\$${quantity * widget.price}',
                              style: AppFonts.style18),
                        ],
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      ShopCubit.get(context).cart.add({
                        'id': widget.id,
                        'name': widget.text,
                        'price': widget.price,
                        'image': widget.image,
                        'discount': 0,
                        'quantity': quantity,
                        'old_price': widget.oldPrice,
                        'total': widget.price * quantity
                      });
                      print(ShopCubit.get(context).cart);
                      showToast('Added to cart',
                          context: context,
                          backgroundColor: AppColors.primaryColor,
                          position: StyledToastPosition.bottom,
                          animation: StyledToastAnimation.slideToTop);
                    },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(
                            child: Text('Add to cart',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text('Buy Now',
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)))),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Details', style: AppFonts.style20B),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child:
                        Text(widget.description, style: AppFonts.style16w500),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
