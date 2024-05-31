import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:newww/components/components.dart';
import 'package:newww/components/constance.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/core/theming/fonts.dart';
import 'package:newww/core/widgets/form_field.dart';
import 'package:newww/core/widgets/pass_from_field.dart';
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
              CashHelper.setUserData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token!;

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ShopLayout()),
                    (route) => false);
              });
            } else {
              showToast(
                state.loginModel.message!,
                context: context,
                backgroundColor: AppColors.primaryColor,
                textStyle: AppFonts.style16,
                animation: StyledToastAnimation.slideFromBottom,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
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
                        const Align(
                          alignment: Alignment.center,
                          child: Image(
                            image: AssetImage(
                              'lib/assets/images/logo.png',
                            ),
                            height: 120,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Text('REGISTER', style: AppFonts.style28B),
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
                        AppFromField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            lapelText: 'Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ('name must not be empty');
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        AppFromField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          lapelText: 'Email',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ('email must not be empty');
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        PassFormField(
                          controller: passController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppFromField(
                            controller: phoneController,
                            lapelText: 'Phone',
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return ('phone must not be empty');
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        state is! RegisterLoadingstate
                            ? Center(
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width / 2,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
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
                            : const Center(child: CircularProgressIndicator()),
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
