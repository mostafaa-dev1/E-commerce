import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:newww/components/components.dart';
import 'package:newww/components/constance.dart';
import 'package:newww/features/login_screen/logic/cubit.dart';
import 'package:newww/features/login_screen/logic/states.dart';
import 'package:newww/features/main_screen/main_screen.dart';
import 'package:newww/core/network/shared_preferences.dart';
import 'package:newww/features/register_screen/shope_register_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginSates>(
        listener: (context, state) {
          if (state is LoginSucssefullystate) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CashHelper.setUserData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token!;
                print(state.loginModel.data!.token!);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ShopLayout()),
                    (route) => false);
              });
            } else {
              print(state.loginModel.message!);

              showToast(
                state.loginModel.message!,
                context: context,
                animation: StyledToastAnimation.slideFromBottom,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Login now and enjoy shopping',
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 55,
                          child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ('email must not be empty');
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey[400]!,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Email',
                                helperStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 13)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 55,
                          child: TextFormField(
                            controller: passController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ('password is too short');
                              }
                            },
                            onFieldSubmitted: (value) {
                              if (formkey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passController.text);
                              }
                            },
                            obscureText: ShopLoginCubit.get(context).isVisiable,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey[400]!,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: 'Password',
                                helperStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 13),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    ShopLoginCubit.get(context)
                                        .IsSufixPressed();
                                  },
                                  icon: Icon(
                                    ShopLoginCubit.get(context).suffix,
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        state is! LoginLoadingstate
                            ? Center(
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width / 2,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: TextButton(
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                          ShopLoginCubit.get(context).userLogin(
                                              email: emailController.text,
                                              password: passController.text);
                                        }
                                      },
                                      child: const Text(
                                        'Sign In',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                ),
                              )
                            : Center(child: CircularProgressIndicator()),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an accont?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()));
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: color),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
