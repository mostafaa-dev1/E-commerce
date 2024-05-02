import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newww/components/constance.dart';
import 'package:newww/core/network/dio_helper/dio_helper.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/logic/home_states.dart';
import 'package:newww/features/main_screen/main_screen.dart';
import 'package:newww/features/login_screen/login_screen.dart';
import 'package:newww/core/network/shared_preferences.dart';

import 'package:newww/features/onboarding/onboarding_screen.dart';

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
                colorScheme: ColorScheme.fromSeed(seedColor: color),
                useMaterial3: true,
                primarySwatch: Colors.deepPurple,
                appBarTheme: const AppBarTheme(
                    surfaceTintColor: Colors.transparent,
                    titleSpacing: 20,
                    titleTextStyle: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    actionsIconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    )),
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  elevation: 10,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.deepPurpleAccent,
                  unselectedItemColor: Colors.black,
                ),
                textTheme: const TextTheme(
                    bodyLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ))),
            darkTheme: ThemeData(
                primarySwatch: Colors.deepPurple,
                appBarTheme: AppBarTheme(
                    titleSpacing: 20,
                    titleTextStyle: const TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                    actionsIconTheme: const IconThemeData(
                      color: Colors.white,
                    ),
                    backgroundColor: HexColor('333739'),
                    elevation: 0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light,
                    )),
                scaffoldBackgroundColor: HexColor('333739'),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    elevation: 10,
                    backgroundColor: HexColor('333739'),
                    selectedItemColor: Colors.deepPurpleAccent,
                    unselectedItemColor: Colors.white,
                    unselectedLabelStyle: const TextStyle(
                      color: Colors.white,
                    )),
                textTheme: const TextTheme(
                    bodyLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ))),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startonBoarding,
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
