import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:newww/core/logic/home_cubit.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/core/theming/fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> text = [
    'My profile',
    'Settings',
    'Help center',
    'Privacy Policy',
    'Invite friends',
    'Logout'
  ];
  List<IconData> icons = [
    IconBroken.Profile,
    IconBroken.Setting,
    IconBroken.Danger,
    IconBroken.Close_Square,
    IconBroken.AddUser,
    IconBroken.Logout,
  ];
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var model = ShopCubit.get(context).userData!.data;
    emailController.text = model!.email!;
    phoneController.text = model.phone!;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          centerTitle: true,
          title: Text(
            'Profile',
            style: AppFonts.style28B,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.primaryColor,
                      child: Container(
                          width: 115,
                          height: 115,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: const Image(
                              fit: BoxFit.fill,
                              height: 110,
                              image: AssetImage('lib/assets/images/me1.jpg'))),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primaryColor,
                      child: Container(
                        height: 35,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              IconBroken.Edit,
                              color: AppColors.primaryColor,
                              size: 20,
                            )),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  model.name!,
                  style: AppFonts.style20B,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300]!,
                            blurRadius: 7,
                            spreadRadius: 1)
                      ]),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.cube_box_fill,
                        color: AppColors.primaryColor,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My orders',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'font2'),
                          ),
                          Text(
                            'You have 5 active orders',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontFamily: 'font3'),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.primaryColor,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[300]!,
                              blurRadius: 7,
                              spreadRadius: 1)
                        ]),
                    child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return item(text[index], icons[index]);
                        },
                        separatorBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 1,
                                width: MediaQuery.sizeOf(context).width / 1.1,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        },
                        itemCount: text.length))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget item(texts, icons) => GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icons,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(texts, style: AppFonts.style15),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
              )
            ],
          )
        ],
      ),
    );
