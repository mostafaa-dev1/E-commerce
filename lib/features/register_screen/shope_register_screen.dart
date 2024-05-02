import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:newww/components/components.dart';
import 'package:newww/components/constance.dart';
import 'package:newww/features/main_screen/main_screen.dart';
import 'package:newww/core/network/shared_preferences.dart';
import 'package:newww/features/onboarding/onboarding_screen.dart';
import 'package:newww/features/register_screen/logic/register_cubit.dart';
import 'package:newww/features/register_screen/logic/register_states.dart';

class RegisterScreen extends StatelessWidget {
  @override
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterSates>(
        listener: (context, state) {
          if (state is RegisterSucssefullystate) {
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
                          'REGISTER',
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
                          'Register now and enjoy shopping',
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 55,
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ('name must not be empty');
                              }
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey[400]!,
                                    )),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'User Name',
                                labelStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 15)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 55,
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ('email must not be empty');
                              }
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey[400]!,
                                    )),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 15)),
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
                                ShopRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            obscureText:
                                ShopRegisterCubit.get(context).isVisiable,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey[400]!,
                                    )),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 15),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    ShopRegisterCubit.get(context)
                                        .IsSufixPressed();
                                  },
                                  icon: Icon(
                                    ShopRegisterCubit.get(context).suffix,
                                  ),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 55,
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ('phone must not be empty');
                              }
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.grey[400]!,
                                    )),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelText: 'Phone',
                                labelStyle: TextStyle(
                                    color: Colors.grey[500], fontSize: 15)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        state is! RegisterLoadingstate
                            ? Center(
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width / 2,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      color: color,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: TextButton(
                                      onPressed: () {
                                        if (formkey.currentState!.validate()) {
                                          ShopRegisterCubit.get(context)
                                              .userRegister(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passController.text,
                                            phone: phoneController.text,
                                          );
                                        }
                                      },
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )),
                                ),
                              )
                            : Center(child: CircularProgressIndicator()),
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
