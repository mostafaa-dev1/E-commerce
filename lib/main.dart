import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newww/components/constance.dart';
import 'package:newww/core/network/dio_helper/dio_helper.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/logic/home_states.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/features/main_screen/main_screen.dart';
import 'package:newww/features/login_screen/login_screen.dart';
import 'package:newww/core/network/shared_preferences.dart';

import 'package:newww/features/onboarding/onboarding_screen.dart';
import 'package:newww/success_pay.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  Widget widget;
  bool? onBoarding = CashHelper.getUserData(key: 'onBoarding') ?? false;
  bool? isPressed = CashHelper.getBoolean(key: 'isPressed') ?? false;
  token = CashHelper.getUserData(key: 'token') ?? ' ';

  // 7683hsdxawmEhS1zNyq56SjX2e3tjNYwFTmfl1mOwwMOUIqE3ubLhDIr1vfCWeFTpuMlMs

  print(token);
  if (onBoarding != null) {
    if (token != ' ') {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp(
    startonBoarding: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startonBoarding;

  MyApp({
    required this.startonBoarding,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..GetHomeData()
        ..GetCategoriesData()
        ..GetFavouritesData()
        ..GetUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
                useMaterial3: true,
                appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent)),
            debugShowCheckedModeBanner: false,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
