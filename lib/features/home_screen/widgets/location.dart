import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:newww/core/theming/colors.dart';
import 'package:newww/core/theming/fonts.dart';
import 'package:newww/search/search_screen.dart';

class Location extends StatelessWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: 80,
      color: Color.fromARGB(249, 246, 246, 246),
      child: Row(children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Location', style: AppFonts.style15),
            const SizedBox(height: 2),
            Row(children: [
              Icon(
                Icons.location_on,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                width: 2,
              ),
              Text('Egypt,Cairo', style: AppFonts.style20w600)
            ])
          ],
        ),
        const Spacer(),
        Icon(
          IconBroken.Notification,
          color: AppColors.primaryColor,
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SearchScreen()));
          },
          child: Icon(
            IconBroken.Search,
            color: AppColors.primaryColor,
          ),
        )
      ]),
    );
  }
}
