import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/core/theming/fonts.dart';
import 'package:newww/search/logic/cubit.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Column(
          children: [
            GestureDetector(
              onTap: () {
                // SearchCubit.get(context)
                //     .Search(ShopCubit.get(context).categories[index]['name']!);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SearchCategory()));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300]!,
                        blurRadius: 7,
                        spreadRadius: 1,
                        offset: const Offset(0, 3))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Center(
                    child: Image(
                      height: 40,
                      image: AssetImage(
                          ShopCubit.get(context).categories[index]['image']!),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(ShopCubit.get(context).categories[index]['name']!,
                overflow: TextOverflow.ellipsis, style: AppFonts.style16w500),
          ],
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        itemCount: ShopCubit.get(context).categories.length,
      ),
    );
  }
}
