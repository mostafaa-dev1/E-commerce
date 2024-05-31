import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/core/theming/fonts.dart';
import 'package:newww/search/logic/cubit.dart';
import 'package:newww/search/logic/states.dart';
import 'package:newww/search/widgets/search_item.dart';

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
              backgroundColor: Color.fromARGB(249, 246, 246, 246),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: searchKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(IconBroken.Arrow___Left),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 50,
                                child: TextFormField(
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
                                  onTap: () {
                                    // SearchCubit.get(context).Search(searchController.text);
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: AppColors.primaryColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.all(10),
                                      enabled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Colors.grey[300]!,
                                            width: 1.0,
                                          )),
                                      hintText: 'Search',
                                      hintStyle: AppFonts.style15,
                                      prefixIcon: const Icon(
                                        Icons.search,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (state is SearchLoadingState)
                          Center(
                              child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              SizedBox(
                                height: 40,
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulse,
                                  colors: [AppColors.primaryColor],
                                  strokeWidth: 2,
                                ),
                              ),
                            ],
                          )),
                        const SizedBox(
                          height: 20,
                        ),
                        state is SearchSuccessState ? SearchItem() : SizedBox()
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
