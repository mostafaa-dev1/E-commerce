import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/theming/colors.dart';

class Banners extends StatelessWidget {
  const Banners({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ShopCubit.get(context).homeModel!;
    return SizedBox(
      height: 250,
      child: Swiper(
          itemCount: model.data!.banners.length,
          autoplay: true,
          pagination: SwiperPagination(builder: SwiperCustomPagination(
              builder: (BuildContext context, SwiperPluginConfig config) {
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
                              ? AppColors.primaryColor
                              : AppColors.primaryColor.withOpacity(0.2),
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
                    image: NetworkImage('${model.data!.banners[index].image}'),
                  ),
                ),
              )),
    );
  }
}
