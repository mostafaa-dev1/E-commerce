import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newww/components/components.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/features/favourites_screen/model/favourites_model.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/search/cubit.dart';
import 'package:newww/search/search_model.dart';
import 'package:newww/search/states.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var searchKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: searchKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Write something';
                          } else {
                            return null;
                          }
                        },
                        onFieldSubmitted: (String text) {
                          if (searchKey.currentState!.validate()) {
                            SearchCubit.get(context).Search(text);
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            labelText: 'Search',
                            prefixIcon: const Icon(
                              Icons.search,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (state is SearchLoadingState)
                        const Center(child: LinearProgressIndicator()),
                      const SizedBox(
                        height: 20,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => BuildSearchItem(
                                SearchCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .data![index],
                                context),
                            separatorBuilder: (context, index) => Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[200],
                            ),
                            itemCount: SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data!
                                .length,
                          ),
                        )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget BuildSearchItem(Product data, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 100,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(data.image!),
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                  if (data.discount! != 0)
                    Container(
                      color: Colors.blue,
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
                        Text(
                          data.price.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: defultColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (data.discount != 0)
                          Text(
                            data.oldPrice.toString(),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopCubit.get(context).ChangeFavourites(data.id!);
                            },
                            icon: CircleAvatar(
                              radius: 17,
                              backgroundColor:
                                  ShopCubit.get(context).favourites[data.id]!
                                      ? defultColor
                                      : Colors.grey,
                              child: const Icon(
                                Icons.favorite_outline,
                                color: Colors.white,
                              ),
                            )),
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
