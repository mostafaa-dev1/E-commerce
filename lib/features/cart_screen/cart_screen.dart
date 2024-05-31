import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:newww/core/categories_model/categories_model.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/logic/home_states.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/features/cart_screen/widgets/cart_item.dart';
import 'package:newww/features/cart_screen/widgets/checkout.dart';
import 'package:newww/features/checkout/checkout.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

import '../../components/constance.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
                centerTitle: true,
                title: const Text('Cart',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'font',
                    ))),
            body: const Column(
              children: [CartItem(), CheckOutButton()],
            ),
          );
        });
  }

  Widget CategoriesItems(CategoriesData Data) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(Data.image!),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            Data.name!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.deepPurpleAccent,
          )
        ],
      ),
    );
  }
}
