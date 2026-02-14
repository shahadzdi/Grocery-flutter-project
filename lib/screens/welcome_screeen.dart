import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery/constants/colors.dart';
import 'package:grocery/extensions/nav.dart';
import 'package:grocery/extensions/screen_size.dart';
import 'package:grocery/screens/log_in_screen.dart';

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
            height: context.screenHeight * 0.3,
            child: Column(
              children: [
                Text(
                  "Welcome to Grocery",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors().darkGreen,
                    fontSize: 60,
                    fontWeight: FontWeight.w900,
                  ),
                ),
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
          ),
          Expanded(
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
                  SvgPicture.asset(
                    "assets/images/grocery.svg",
                    height: context.screenHeight * 0.3,
                    width: context.screenHeight,
                  ),
                  SizedBox(height: context.screenHeight * 0.1),
                  SizedBox(
                    height: 60,
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        context.navToScreen(LogInScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors().black,
                        foregroundColor: AppColors().creamBg,
                        minimumSize: const Size(double.infinity, 55),
                        elevation: 0,
                      ),
                      child: Text(
                        "Start",
                        style: TextStyle(
                          color: AppColors().creamBg,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
