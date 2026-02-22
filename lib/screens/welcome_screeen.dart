import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/extensions/nav.dart';
import 'package:grocery/extensions/screen_size.dart';
import 'package:grocery/screens/log_in_screen.dart';
import 'package:grocery/widgets/nav_button.dart';

class Welcomescreeen extends StatelessWidget {
  const Welcomescreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().creamBg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 60),
            height: context.screenHeight * 0.35,
            child: Column(
              children: [
                // ----- welcome texts -----
                Text(
                  "Welcome to Grocery",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors().darkGreen,
                    fontSize: 60,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "fresh products",
                      style: TextStyle(
                        color: AppColors().darkGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            // ----- green continer ------
            child: Container(
              height: context.screenHeight * 0.8,
              width: context.screenWidth,
              decoration: BoxDecoration(
                color: AppColors().green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(150),
                  topRight: Radius.circular(150),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ----- svg image -----
                  SvgPicture.asset(
                    "assets/images/grocery.svg",
                    height: context.screenHeight * 0.3,
                    width: context.screenHeight,
                  ),
                  SizedBox(height: context.screenHeight * 0.1),
                  SizedBox(
                    height: 60,
                    width: 300,
                    // ----- start button -----
                    child: NavButton(
                      backgroundColor: AppColors().black,
                      text: "Start",
                      textColor: AppColors().creamBg,
                      onPressed: () {
                        context.navToScreen(LogInScreen());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
